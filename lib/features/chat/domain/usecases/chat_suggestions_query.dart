import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/datasources/chat_suggestions_remote_data_source.dart';

class ChatSuggestionsWithQuery implements UseCase<Either<Failure, void>, String> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatSuggestionsRemoteDataSource chatRemoteDataSource;
  final AuthAutoSignIn authAutoSignIn;

  const ChatSuggestionsWithQuery({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatRemoteDataSource,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, void>> call(String query) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    chatBloc.add(SetSuggestionsInProcess(suggestionsInProcess: true));
    final chatsResult = await chatRemoteDataSource.getSuggestions(token, query);
    return chatsResult.fold(
      (failure) async {
        if (failure is TokenExpiredFailure) {
          return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(query));
        } else {
          chatBloc.add(SetIsInProcess(isInProcess: false));
          chatBloc.add(SetSuggestionsInProcess(suggestionsInProcess: false));
          return Left(failure);
        }
      },
      (result) async {
        chatBloc.add(SetSuggestionsResponseEvent(suggestionsResponse: result));
        chatBloc.add(SetSuggestionsInProcess(suggestionsInProcess: false));
        return Right(null);
      },
    );
  }
}
