import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetVoices implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;

  const TtsGetVoices({required this.ttsBloc, required this.ttsService});

  @override
  Future<void> call(NoParams params) async {
    LoggerService.logDebug('TtsGetVoices -> call()');
    final voices = await ttsService.getVoices();
    ttsBloc.add(UpdateTtsVoices(voices: voices));
  }
}
