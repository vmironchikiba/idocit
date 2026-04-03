import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/enums/stt_actions.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';

class SttStartStop implements UseCase<Either<Failure, void>, SttActions> {
  final NetworkListenerService networkListenerService;
  final SttBloc sttBloc;
  final SttService sttService;

  const SttStartStop({required this.networkListenerService, required this.sttBloc, required this.sttService});

  @override
  Future<Either<Failure, void>> call(SttActions sttActions) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(sttActions))) {
      return const Left(NetworkFailure());
    }
    switch (sttActions) {
      case SttActions.stop:
        sttService.stopListening();
      case SttActions.start:
        sttService.startListening();
      case SttActions.cancel:
        sttService.cancelListening();
    }
    sttBloc.add(UpdateSttIsStarted(isStarted: sttActions.toBool()));
    return Right(null);
  }
}
