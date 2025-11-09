import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';

class IdocItLazyInitChats implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final IdocItBloc idocItBloc;
  final AuthBloc authBloc;
  final IdocItRemoteDataSource idocItRemoteDataSource;

  const IdocItLazyInitChats({
    required this.networkListenerService,
    required this.idocItBloc,
    required this.authBloc,
    required this.idocItRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatsResult = await idocItRemoteDataSource.getChats(token);
    return chatsResult.fold(
      (failure) async {
        return Left(NetworkFailure());
      },
      (result) async {
        idocItBloc.add(SetChatsEvent(chats: result));
        return Right(null);
      },
    );
  }
}
