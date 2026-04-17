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

class IdocItLazyInitChats implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final IdocItBloc idocItBloc;
  final AuthBloc authBloc;
  final IdocItRemoteDataSource idocItRemoteDataSource;
  final AuthAutoSignIn authAutoSignIn;

  const IdocItLazyInitChats({
    required this.networkListenerService,
    required this.idocItBloc,
    required this.authBloc,
    required this.idocItRemoteDataSource,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    // idocItBloc.add(IdocItResetEvent());
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatsResult = await idocItRemoteDataSource.getChats(token);
    return chatsResult.fold(
      (failure) async {
        if (failure is TokenExpiredFailure) {
          return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(params));
        } else {
          return Left(failure);
        }
      },
      (result) async {
        idocItBloc.add(SetChatsEvent(chats: result));
        return Right(null);
      },
    );
  }
}
