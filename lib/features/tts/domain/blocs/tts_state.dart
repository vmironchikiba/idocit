part of 'tts_bloc.dart';

class TtsState {
  final bool isEnabled;
  final TtsStateEnum ttsState;
  final double volume;
  final double pitch;
  final double rate;
  final List<TtsEngine> engines;
  final List<TtsLanguage> languages;
  final List<TtsVoice> voices;
  final TtsEngine? defaultEngine;
  final TtsEngine? currentEngine;
  final TtsVoice? defaultVoice;
  final TtsVoice? currentVoice;
  final String? voiceText;
  final TtsLanguage? currentLanguage;
  const TtsState({
    required this.isEnabled,
    required this.ttsState,
    required this.volume,
    required this.pitch,
    required this.rate,
    required this.engines,
    required this.languages,
    required this.voices,
    required this.defaultEngine,
    required this.currentEngine,
    required this.defaultVoice,
    required this.currentVoice,
    required this.voiceText,
    required this.currentLanguage,
  });

  factory TtsState.initial() {
    return const TtsState(
      isEnabled: false,
      ttsState: TtsStateEnum.stopped,
      volume: 0.8,
      pitch: 1.0,
      rate: !kIsWeb ? 0.5 : 0.9,
      engines: [],
      languages: [],
      voices: [],
      defaultEngine: null,
      currentEngine: null,
      defaultVoice: null,
      currentVoice: null,
      voiceText: null,
      currentLanguage: null,
    );
  }

  TtsState update({
    bool? isEnabled,
    TtsStateEnum? ttsState,
    double? volume,
    double? pitch,
    double? rate,
    List<TtsEngine>? engines,
    List<TtsLanguage>? languages,
    List<TtsVoice>? voices,
    TtsEngine? defaultEngine,
    TtsEngine? currentEngine,
    TtsVoice? defaultVoice,
    TtsVoice? currentVoice,
    String? voiceText,
    TtsLanguage? currentLanguage,
  }) {
    return TtsState(
      isEnabled: isEnabled ?? this.isEnabled,
      ttsState: ttsState ?? this.ttsState,
      volume: volume ?? this.volume,
      pitch: pitch ?? this.pitch,
      rate: rate ?? this.rate,
      engines: engines ?? this.engines,
      languages: languages ?? this.languages,
      voices: voices ?? this.voices,
      defaultEngine: defaultEngine ?? this.defaultEngine,
      currentEngine: currentEngine ?? this.currentEngine,
      defaultVoice: defaultVoice ?? this.defaultVoice,
      currentVoice: currentVoice ?? this.currentVoice,
      voiceText: voiceText ?? this.voiceText,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }

  TtsState reset({
    bool defaultEngine = false,
    bool currentEngine = false,
    bool defaultVoice = false,
    bool currentVoice = false,
    bool voiceText = false,
    bool currentLanguage = false,
  }) {
    return TtsState(
      isEnabled: isEnabled,
      ttsState: ttsState,
      volume: volume,
      pitch: pitch,
      rate: rate,
      engines: engines,
      languages: languages,
      voices: voices,
      defaultEngine: defaultEngine ? null : this.defaultEngine,
      currentEngine: currentEngine ? null : this.currentEngine,
      defaultVoice: defaultVoice ? null : this.defaultVoice,
      currentVoice: currentVoice ? null : this.currentVoice,
      voiceText: voiceText ? null : this.voiceText,
      currentLanguage: currentLanguage ? null : this.currentLanguage,
    );
  }
}
