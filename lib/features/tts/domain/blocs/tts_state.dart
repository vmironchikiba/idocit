part of 'tts_bloc.dart';

class TtsState {
  final TtsStateEnum ttsState;
  final double volume;
  final double pitch;
  final double rate;
  final List<String> engines;
  final List<String> languages;
  final List<Map<String, String>> voices;
  final String? voiceText;
  const TtsState({
    required this.ttsState,
    required this.volume,
    required this.pitch,
    required this.rate,
    required this.engines,
    required this.languages,
    required this.voices,
    required this.voiceText,
  });

  factory TtsState.initial() {
    return const TtsState(
      ttsState: TtsStateEnum.stopped,
      volume: 0.8,
      pitch: 1.0,
      rate: !kIsWeb ? 0.5 : 0.9,
      engines: [],
      languages: [],
      voices: [],
      voiceText: null,
    );
  }

  TtsState update({
    TtsStateEnum? ttsState,
    double? volume,
    double? pitch,
    double? rate,
    List<String>? engines,
    List<String>? languages,
    List<Map<String, String>>? voices,
    String? voiceText,
  }) {
    return TtsState(
      ttsState: ttsState ?? this.ttsState,
      volume: volume ?? this.volume,
      pitch: pitch ?? this.pitch,
      rate: rate ?? this.rate,
      engines: engines ?? this.engines,
      languages: languages ?? this.languages,
      voices: voices ?? this.voices,
      voiceText: voiceText ?? this.voiceText,
    );
  }
}
