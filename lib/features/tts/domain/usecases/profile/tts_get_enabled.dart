import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsGetEnabled implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetEnabled({required this.ttsBloc, required this.ttsPreferencesStorage});

  @override
  Future<void> call(NoParams isEnabled) async =>
      ttsBloc.add(UpdateTtsIsEnabled(isEnabled: await ttsPreferencesStorage.readIsEnabled()));
}
