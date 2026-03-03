import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';

class TtsConfig {
  final TtsEngine? engine;
  final TtsLanguage? language;
  final TtsVoice? voice;
  final double pitch;
  final double rate;

  const TtsConfig({this.engine, this.language, this.voice, this.pitch = 1.0, this.rate = 0.5});

  TtsConfig copyWith({TtsEngine? engine, TtsLanguage? language, TtsVoice? voice, double? pitch, double? rate}) {
    return TtsConfig(
      engine: engine ?? this.engine,
      language: language ?? this.language,
      voice: voice ?? this.voice,
      pitch: pitch ?? this.pitch,
      rate: rate ?? this.rate,
    );
  }
}
