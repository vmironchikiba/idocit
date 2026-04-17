import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/datasources/chat_history_remote_datasource.dart';

class GetChatHistory implements UseCase<Either<Failure, void>, String> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatHistoryRemoteDataSource chatHistoryRemoteDataSource;
  final AuthAutoSignIn authAutoSignIn;

  const GetChatHistory({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatHistoryRemoteDataSource,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, void>> call(String chatId) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    if (chatId.trim().isEmpty) return Right(null);
    chatBloc.add(SetIsInProcess(isInProcess: true));
    chatBloc.add(SetChatHistoryMessages(chatHistoryMessages: []));
    final chatsResult = await chatHistoryRemoteDataSource.getChats(token, chatId);
    return chatsResult.fold(
      (failure) async {
        if (failure is TokenExpiredFailure) {
          return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(chatId));
        } else {
          chatBloc.add(SetIsInProcess(isInProcess: false));
          return Left(failure);
        }
      },
      (result) async {
        chatBloc.add(SetChatHistoryMessages(chatHistoryMessages: result));
        chatBloc.add(SetIsInProcess(isInProcess: false));
        return Right(null);
      },
    );
  }
}
