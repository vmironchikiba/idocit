import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsSetRate implements UseCase<void, double> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetRate({required this.ttsBloc, required this.ttsPreferencesStorage, required this.ttsService});

  @override
  Future<void> call(double rate) async {
    LoggerService.logDebug('TtsSetRate -> call($rate)');
    await ttsPreferencesStorage.writeRate(rate);
    await ttsService.setSpeechRate(rate);
    ttsBloc.add(UpdateTtsRate(rate: rate));
  }
}
