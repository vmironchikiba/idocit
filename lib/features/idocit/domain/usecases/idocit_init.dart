import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
// import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';

// import 'package:idocit/injection_container.dart';

class IdocItInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final IdocItBloc idocItBloc;

  const IdocItInit({required this.networkListenerService, required this.idocItBloc});

  @override
  Future<Either<Failure, void>> call(NoParams params, {bool isCleanReset = false, bool withArchivedDate = true}) async {
    LoggerService.logDebug('IdocItInit -> call(isCleanReset: $isCleanReset, withArchivedDate: $withArchivedDate)');

    if (!await networkListenerService.checkNetworkConnection(
      () => call(params, isCleanReset: isCleanReset, withArchivedDate: withArchivedDate),
    )) {
      return const Left(NetworkFailure());
    }
    return const Right(null);
  }
}
