import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsGetRate implements UseCase<void, NoParams> {
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetRate({required this.ttsBloc, required this.ttsPreferencesStorage});

  @override
  Future<void> call(NoParams prams) async {
    final rate = await ttsPreferencesStorage.readRate();
    ttsBloc.add(UpdateTtsRate(rate: rate));
  }
}
