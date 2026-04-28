import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_get_init_chats.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_get_next_chats.dart';

class IdocItDeleteChat implements UseCase<Either<Failure, void>, String> {
  final NetworkListenerService networkListenerService;
  final IdocItBloc idocItBloc;
  final AuthBloc authBloc;
  final IdocItRemoteDataSource idocItRemoteDataSource;
  final IdocGetInitChats idocItInitChats;
  final AuthAutoSignIn authAutoSignIn;

  const IdocItDeleteChat({
    required this.networkListenerService,
    required this.idocItBloc,
    required this.authBloc,
    required this.idocItRemoteDataSource,
    required this.idocItInitChats,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, void>> call(String chatId) async {
    LoggerService.logDebug('IdocItDeleteChat -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final deleteChatResult = await idocItRemoteDataSource.deleteChat(token, chatId: chatId);
    return deleteChatResult.fold((failure) async {
      if (failure is TokenExpiredFailure) {
        return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(chatId));
      } else {
        return Left(failure);
      }
    }, (_) async => await idocItInitChats.call(NoParams()));
  }
}
