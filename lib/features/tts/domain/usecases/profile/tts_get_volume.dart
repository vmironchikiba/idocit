import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetVolume implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetVolume({required this.ttsBloc, required this.ttsPreferencesStorage, required this.ttsService});

  @override
  Future<void> call(NoParams prams) async {
    final volume = await ttsPreferencesStorage.readVolume();
    if (volume == null) return;
    await ttsService.setVolume(volume);
    ttsBloc.add(UpdateTtsVolume(volume: volume));
  }
}
