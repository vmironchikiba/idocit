import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsSetRate implements UseCase<void, double> {
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetRate({required this.ttsBloc, required this.ttsPreferencesStorage});

  @override
  Future<void> call(double rate) async {
    LoggerService.logDebug('TtsSetRate -> call($rate)');
    await ttsPreferencesStorage.writeRate(rate);
    ttsBloc.add(UpdateTtsRate(rate: rate));
  }
}
