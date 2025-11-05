import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_init.dart';
import 'package:idocit/injection_container.dart';

class AuthInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final IdocItInit idocItInit;

  const AuthInit({required this.networkListenerService, required this.idocItInit});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('AuthInit -> call()');

    return const Right(null);
  }
}
