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
import 'package:idocit/features/chat/domain/datasources/chat_history_remote_datasource.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';

class GetChatHistory implements UseCase<Either<Failure, void>, String> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatHistoryRemoteDataSource chatHistoryRemoteDataSource;

  const GetChatHistory({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatHistoryRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(String chatId) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatsResult = await chatHistoryRemoteDataSource.getChats(token, chatId);
    return chatsResult.fold(
      (failure) async {
        return Left(NetworkFailure());
      },
      (result) async {
        // idocItBloc.add(SetChatsEvent(chats: result));
        return Right(null);
      },
    );
  }
}
