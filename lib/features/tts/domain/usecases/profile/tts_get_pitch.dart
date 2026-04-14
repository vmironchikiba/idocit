import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetPitch implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetPitch({required this.ttsBloc, required this.ttsPreferencesStorage, required this.ttsService});

  @override
  Future<void> call(NoParams prams) async {
    final pitch = await ttsPreferencesStorage.readPitch();
    if (pitch == null) return;
    await ttsService.setPitch(pitch);
    ttsBloc.add(UpdateTtsPitch(pitch: pitch));
  }
}
