import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsStop implements UseCase<void, NoParams> {
  final TtsService ttsService;
  final ChatStartCompletionsStream chatStartCompletionsStream;

  const TtsStop({required this.ttsService, required this.chatStartCompletionsStream});

  @override
  Future<void> call(NoParams currentVoice) async {
    LoggerService.logDebug('TtsStop -> call()');
    await ttsService.stop();
    chatStartCompletionsStream.reset();
  }
}
