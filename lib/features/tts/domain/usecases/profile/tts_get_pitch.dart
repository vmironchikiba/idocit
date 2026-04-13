import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsGetPitch implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetPitch({required this.ttsBloc, required this.ttsPreferencesStorage});

  @override
  Future<void> call(NoParams prams) async {
    final pitch = await ttsPreferencesStorage.readPitch();
    ttsBloc.add(UpdateTtsPitch(pitch: pitch));
  }
}
