import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';

class SttStartStop implements UseCase<Either<Failure, void>, TssActions> {
  final NetworkListenerService networkListenerService;
  final SttBloc sttBloc;
  final SttService sttService;

  const SttStartStop({required this.networkListenerService, required this.sttBloc, required this.sttService});

  @override
  Future<Either<Failure, void>> call(TssActions tssActions) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(tssActions))) {
      return const Left(NetworkFailure());
    }
    switch (tssActions) {
      case TssActions.stopped:
        sttService.stopListening();
      case TssActions.started:
        sttService.startListening();
      case TssActions.canceled:
        sttService.cancelListening();
    }
    sttBloc.add(UpdateSttIsStarted(isStarted: tssActions.toBool()));
    return Right(null);
  }
}

enum TssActions { stopped, started, canceled }

extension TssActionsToBool on TssActions {
  bool toBool() => this == TssActions.started;
}
