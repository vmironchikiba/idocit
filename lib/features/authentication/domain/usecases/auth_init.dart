import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/injection_container.dart';

class AuthInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;

  const AuthInit({required this.networkListenerService});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('AuthInit -> call()');

    locator<InAppFailureProvider>().addEvent(toString());
    if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
      locator<InAppFailureProvider>().removeEvent(toString());
      return const Left(NetworkFailure());
    }

    locator<InAppFailureProvider>().removeEvent(toString());
    return const Right(null);
  }
}
