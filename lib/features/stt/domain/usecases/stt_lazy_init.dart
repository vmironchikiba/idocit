import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';

class SttLazyInit implements UseCase<Either<Failure, void>, SpeechToTextConfig> {
  final NetworkListenerService networkListenerService;
  final SttBloc sttBloc;
  final SttService sttService;

  const SttLazyInit({required this.networkListenerService, required this.sttBloc, required this.sttService});

  @override
  Future<Either<Failure, void>> call(SpeechToTextConfig options) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(options))) {
      return const Left(NetworkFailure());
    }
    await sttService.initSpeechState(currentOptions: options);
    sttBloc.add(UpdateSttIsEnabled(isEnabled: sttService.hasSpeech));
    return sttService.hasSpeech ? Right(null) : Left(SttNotExistsFailure());
  }
}
