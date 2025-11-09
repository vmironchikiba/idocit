import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/datasources/components_remote_datasource.dart';

class ComponentsGetComponents implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ComponentsBloc componentsBloc;
  final AuthBloc authBloc;
  final ComponentsRemoteDataSource componentsRemoteDataSource;

  const ComponentsGetComponents({
    required this.networkListenerService,
    required this.componentsBloc,
    required this.authBloc,
    required this.componentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('ChatGetComponents -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final componentsResult = await componentsRemoteDataSource.getComponents(token);
    return componentsResult.fold(
      (failure) async {
        return Left(NetworkFailure());
      },
      (result) async {
        componentsBloc.add(SetComponentConfigEvent(componentConfig: result));
        return Right(null);
      },
    );
  }
}
