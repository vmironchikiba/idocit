import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsSetVolume implements UseCase<void, double> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetVolume({required this.ttsBloc, required this.ttsPreferencesStorage, required this.ttsService});

  @override
  Future<void> call(double volume) async {
    LoggerService.logDebug('TtsSetVolume -> call($volume)');
    await ttsPreferencesStorage.writeVolume(volume);
    await ttsService.setVolume(volume);
    ttsBloc.add(UpdateTtsVolume(volume: volume));
  }
}
