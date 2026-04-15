import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetMaxSpeechInputLength implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;

  const TtsGetMaxSpeechInputLength({required this.ttsBloc, required this.ttsService});

  @override
  Future<void> call(NoParams params) async {
    LoggerService.logDebug('TtsGetEngines -> call()');
    final maxSpeechInputLength = await ttsService.getMaxSpeechInputLengthTts() as int?;
    ttsBloc.add(UpdateTtsMaxSpeechInputLength(maxSpeechInputLength: maxSpeechInputLength));
  }
}
