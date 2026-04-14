import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetEngines implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;

  const TtsGetEngines({required this.ttsBloc, required this.ttsService});

  @override
  Future<void> call(NoParams params) async {
    LoggerService.logDebug('TtsGetEngines -> call()');
    final engines = await ttsService.getEngines();
    ttsBloc.add(UpdateTtsEngines(engines: engines));
  }
}
