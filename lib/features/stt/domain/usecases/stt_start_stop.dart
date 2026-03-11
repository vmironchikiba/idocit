import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';

class SttStartStop implements UseCase<Either<Failure, void>, bool> {
  final NetworkListenerService networkListenerService;
  final SttBloc sttBloc;
  final SttService sttService;

  const SttStartStop({required this.networkListenerService, required this.sttBloc, required this.sttService});

  @override
  Future<Either<Failure, void>> call(bool isStarted) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(isStarted))) {
      return const Left(NetworkFailure());
    }
    if (isStarted) {
      sttService.startListening();
    } else {
      sttService.stopListening();
    }
    sttBloc.add(UpdateSttIsStarted(isStarted: isStarted));
    return Right(null);
  }
}
