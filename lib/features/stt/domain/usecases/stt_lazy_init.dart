import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';

class SttLazyInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final SttBloc sttBloc;
  final SttService sttService;

  const SttLazyInit({required this.networkListenerService, required this.sttBloc, required this.sttService});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
      return const Left(NetworkFailure());
    }
    await sttService.initSpeechState();
    sttBloc.add(UpdateSttIsEnabled(isEnabled: sttService.hasSpeech));
    return sttService.hasSpeech ? Right(null) : Left(SttNotExistsFailure());
  }
}
