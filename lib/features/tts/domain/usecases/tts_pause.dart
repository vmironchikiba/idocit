import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsPause implements UseCase<void, NoParams> {
  final TtsService ttsService;

  const TtsPause({required this.ttsService});

  @override
  Future<void> call(NoParams currentVoice) async {
    LoggerService.logDebug('TtsStop -> call()');
    await ttsService.stop();
  }
}
