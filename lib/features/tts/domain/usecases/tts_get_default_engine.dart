import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_current_engine.dart';

class TtsGetDefaultEngine implements UseCase<void, NoParams> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;
  final TtsSetCurrentEngine ttsSetCurrentEngine;
  const TtsGetDefaultEngine({
    required this.networkListenerService,
    required this.ttsBloc,
    required this.ttsService,
    required this.ttsPreferencesStorage,
    required this.ttsSetCurrentEngine,
  });
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  @override
  Future<void> call(NoParams? param) async {
    LoggerService.logDebug('TtsGetDefaultEngine -> call()');
    if (!isAndroid) return; // safety-check
    LoggerService.logDebug('_getDefaultEngine...');
    final storedEngine = await ttsPreferencesStorage.readDefaultEngine();
    var defaultEngine = await ttsService.getDefaultEngine();

    if (storedEngine?.name != defaultEngine.name) await ttsPreferencesStorage.writeDefaultEngine(defaultEngine);
    LoggerService.logDebug('Default Engine: $defaultEngine');
    ttsBloc.add(UpdateTtsDefaultEngine(defaultEngine: defaultEngine));
    await ttsSetCurrentEngine.call(defaultEngine);
  }
}
