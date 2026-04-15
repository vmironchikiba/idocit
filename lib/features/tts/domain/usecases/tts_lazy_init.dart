import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_enabled.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_pitch.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_rate.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_volume.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_default_engine.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_engines.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_languages.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_voices.dart';

class TtsLazyInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsGetEnabled ttsGetEnabled;
  final TtsGetPitch ttsGetPitch;
  final TtsGetRate ttsGetRate;
  final TtsGetVolume ttsGetVolume;
  final TtsGetDefaultEngine ttsGetDefaultEngine;
  final TtsGetEngines ttsGetEngines;
  final TtsGetLanguages ttsGetLanguages;
  final TtsGetVoices ttsGetVoices;

  const TtsLazyInit({
    required this.networkListenerService,
    required this.ttsBloc,
    required this.ttsService,
    required this.ttsGetEnabled,
    required this.ttsGetPitch,
    required this.ttsGetRate,
    required this.ttsGetVolume,
    required this.ttsGetDefaultEngine,
    required this.ttsGetEngines,
    required this.ttsGetLanguages,
    required this.ttsGetVoices,
  });
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('TtsLazyInit -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
      return const Left(NetworkFailure());
    }
    await ttsService.init();
    await ttsGetLanguages.call(NoParams());
    await ttsGetVoices.call(NoParams());
    if (isAndroid) await ttsGetEngines.call(NoParams());
    if (isAndroid) await ttsGetDefaultEngine.call(NoParams());
    await ttsGetEnabled.call(NoParams());
    await ttsGetPitch.call(NoParams());
    await ttsGetRate.call(NoParams());
    await ttsGetVolume.call(NoParams());

    return Right(null);
  }
}
