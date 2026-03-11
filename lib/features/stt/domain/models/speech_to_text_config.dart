import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextConfig {
  final SpeechListenOptions options;
  final String localeId;
  final bool logEvents;
  final bool debugLogging;
  final int pauseFor;
  final int listenFor;

  SpeechToTextConfig(this.options, this.localeId, this.pauseFor, this.listenFor, this.logEvents, this.debugLogging);
  SpeechToTextConfig copyWith({
    SpeechListenOptions? options,
    String? localeId,
    bool? logEvents,
    int? pauseFor,
    int? listenFor,
    bool? debugLogging,
  }) {
    return SpeechToTextConfig(
      options ?? this.options,
      localeId ?? this.localeId,
      pauseFor ?? this.pauseFor,
      listenFor ?? this.listenFor,
      logEvents ?? this.logEvents,
      debugLogging ?? this.debugLogging,
    );
  }
}
