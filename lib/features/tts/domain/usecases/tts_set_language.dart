import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_is_current_language_installed.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_is_current_language_installed.dart';

class TtsSetLanguage implements UseCase<void, TtsLanguage> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;
  final TtsGetIsCurrentLanguageInstalled ttsGetIsCurrentLanguageInstalled;

  const TtsSetLanguage({
    required this.networkListenerService,
    required this.ttsBloc,
    required this.ttsService,
    required this.ttsPreferencesStorage,
    required this.ttsGetIsCurrentLanguageInstalled,
  });

  @override
  Future<void> call(TtsLanguage? currentLanguage) async {
    LoggerService.logDebug('TtsSetLanguage -> call(${currentLanguage?.code})');
    ttsBloc.add(UpdateTtsCurrentLanguage(currentLanguage: currentLanguage));
    await ttsGetIsCurrentLanguageInstalled.call(currentLanguage);
  }
}
