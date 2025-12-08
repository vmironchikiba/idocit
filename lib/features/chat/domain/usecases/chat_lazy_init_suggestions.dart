import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/datasources/chat_suggestions_remote_data_source.dart';
import 'package:idocit/features/chat/domain/datasources/open_ai_stream_api.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatLazyInitSuggestions implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatSuggestionsRemoteDataSource chatRemoteDataSource;

  const ChatLazyInitSuggestions({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatsResult = await chatRemoteDataSource.getSuggestions(token, '');
    return chatsResult.fold(
      (failure) async {
        return Left(NetworkFailure());
      },
      (result) async {
        chatBloc.add(SetSuggestionsResponseEvent(suggestionsResponse: result));
        return Right(null);
      },
    );
  }
}
