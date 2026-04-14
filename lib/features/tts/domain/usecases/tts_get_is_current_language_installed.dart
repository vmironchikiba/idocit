import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetIsCurrentLanguageInstalled implements UseCase<void, TtsLanguage?> {
  final TtsBloc ttsBloc;
  final TtsService ttsService;

  const TtsGetIsCurrentLanguageInstalled({required this.ttsBloc, required this.ttsService});
  bool get _isAndroid => !kIsWeb && Platform.isAndroid;
  @override
  Future<void> call(TtsLanguage? language) async => ttsBloc.add(
    UpdateTtsIsCurrentLanguageInstalled(
      isCurrentLanguageInstalled:
          _isAndroid &&
          (language != null
              ? await ttsService.isLanguageInstalled(language)
              : (ttsBloc.state.currentLanguage != null &&
                    await ttsService.isLanguageInstalled(ttsBloc.state.currentLanguage!))),
    ),
  );
}
