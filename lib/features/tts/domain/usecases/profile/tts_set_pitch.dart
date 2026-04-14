import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsSetPitch implements UseCase<void, double> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetPitch({required this.ttsBloc, required this.ttsPreferencesStorage, required this.ttsService});

  @override
  Future<void> call(double pitch) async {
    LoggerService.logDebug('TtsSetPitch -> call($pitch)');
    await ttsPreferencesStorage.writePitch(pitch);
    await ttsService.setPitch(pitch);
    ttsBloc.add(UpdateTtsPitch(pitch: pitch));
  }
}
