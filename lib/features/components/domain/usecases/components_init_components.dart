import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/usecases/components_get_components.dart';
import 'package:idocit/injection_container.dart';

class ComponentsInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ComponentsBloc componentsBloc;

  const ComponentsInit({required this.networkListenerService, required this.componentsBloc});

  @override
  Future<Either<Failure, void>> call(NoParams params, {bool isCleanReset = false, bool withArchivedDate = true}) async {
    LoggerService.logDebug('IdocItInit -> call(isCleanReset: $isCleanReset, withArchivedDate: $withArchivedDate)');

    if (!await networkListenerService.checkNetworkConnection(
      () => call(params, isCleanReset: isCleanReset, withArchivedDate: withArchivedDate),
    )) {
      return const Left(NetworkFailure());
    }
    componentsBloc.add(ResetComponentConfigEvent());
    final componentsResult = await locator<ComponentsGetComponents>().call(NoParams());
    return componentsResult.fold(
      (failure) async {
        return Left(failure);
      },
      (_) async {
        return Right(null);
      },
    );
  }
}
