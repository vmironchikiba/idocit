import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsSetPitch implements UseCase<void, double> {
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetPitch({required this.ttsBloc, required this.ttsPreferencesStorage});

  @override
  Future<void> call(double pitch) async {
    LoggerService.logDebug('TtsSetPitch -> call($pitch)');
    await ttsPreferencesStorage.writePitch(pitch);
    ttsBloc.add(UpdateTtsPitch(pitch: pitch));
  }
}
