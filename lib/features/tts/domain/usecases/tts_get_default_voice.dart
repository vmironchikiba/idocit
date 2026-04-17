import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_voice.dart';

class TtsGetDefaultVoice implements UseCase<Either<Failure, TtsVoice>, List<TtsVoice>> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;
  final TtsSetVoice ttsSetVoice;

  const TtsGetDefaultVoice({required this.ttsBloc, required this.ttsService, required this.ttsSetVoice});
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  @override
  Future<Either<Failure, TtsVoice>> call(List<TtsVoice> rawVoices) async {
    LoggerService.logDebug('TtsGetVoices -> call()');
    if (isAndroid) {
      var json = await ttsService.getDefaultVoiceTts();
      final defVoice = TtsVoice.fromJson(json);
      LoggerService.logDebug('Android Default Voice: $defVoice');
      if (json != null) {
        var rawVoice = rawVoices.firstWhere((v) => v == defVoice, orElse: () => TtsVoice.nullVoice);
        await ttsSetVoice.call(rawVoice.optional);
        final voiceTts = ttsBloc.state.currentVoice;
        return voiceTts != null ? Right(voiceTts) : Left(CommonFailure(message: 'No Voice'));
      } else {
        return Left(CommonFailure(message: 'No Voice'));
      }
    } else {
      String myLocale;
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      LoggerService.logDebug('Device Locale (ISO): $deviceLocale');
      // TTS uses Unicode BCP47 Locale Identifiers instead of the ISO standard
      myLocale = deviceLocale.toLanguageTag();
      LoggerService.logDebug('Device/Browser Locale (BCP47): $myLocale');
      // TTS auto-selects the first matching raw voice with locale
      var rawVoiceTts = rawVoices.firstWhere(
        (v) => v.locale == myLocale,
        orElse: () => rawVoices.firstWhere(
          (v) => v.locale.startsWith(myLocale),
          orElse: () => rawVoices.firstWhere(
            (v) => v.locale.startsWith(deviceLocale.languageCode),
            orElse: () => TtsVoice.nullVoice,
          ),
        ),
      );
      await ttsSetVoice.call(rawVoiceTts.optional);
      final voiceTts = ttsBloc.state.currentVoice;
      LoggerService.logDebug('Computed Default Voice: ${voiceTts?.name}');
      return voiceTts != null ? Right(voiceTts) : Left(CommonFailure(message: 'No Voice'));
    }
  }
}
