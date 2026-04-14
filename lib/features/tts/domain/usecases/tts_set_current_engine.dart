import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsSetCurrentEngine implements UseCase<void, TtsEngine> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetCurrentEngine({
    required this.networkListenerService,
    required this.ttsBloc,
    required this.ttsService,
    required this.ttsPreferencesStorage,
  });

  @override
  Future<void> call(TtsEngine? currentEngine) async {
    LoggerService.logDebug('TtsSetLanguage -> call(${currentEngine?.name})');
    ttsBloc.add(UpdateTtsCurrentEngine(currentEngine: currentEngine));
  }
}
