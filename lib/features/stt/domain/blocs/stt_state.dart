part of 'stt_bloc.dart';

class SttState {
  final bool isEnabled;
  final bool isStarted;
  final SpeechRecognitionResult? speechRecognitionResult;
  final double level;
  final SttStatus? lastStatus;
  final List<LocaleName> localeNames;
  final LocaleName? systemLocale;
  final SttSpeechFailure? lastFailure;
  final SpeechToTextConfig? currentOptions;

  const SttState({
    required this.isEnabled,
    required this.isStarted,
    required this.speechRecognitionResult,
    required this.level,
    required this.lastStatus,
    required this.localeNames,
    required this.systemLocale,
    required this.lastFailure,
    required this.currentOptions,
  });

  factory SttState.initial() {
    return const SttState(
      isEnabled: false,
      isStarted: false,
      speechRecognitionResult: null,
      level: 0.0,
      lastStatus: null,
      localeNames: [],
      systemLocale: null,
      lastFailure: null,
      currentOptions: null,
    );
  }

  SttState update({
    bool? isEnabled,
    bool? isStarted,
    SpeechRecognitionResult? speechRecognitionResult,
    double? level,
    SttStatus? lastStatus,
    List<LocaleName>? localeNames,
    LocaleName? systemLocale,
    SttSpeechFailure? lastFailure,
    SpeechToTextConfig? currentOptions,
  }) {
    return SttState(
      isEnabled: isEnabled ?? this.isEnabled,
      isStarted: isStarted ?? this.isStarted,
      speechRecognitionResult: speechRecognitionResult ?? this.speechRecognitionResult,
      level: level ?? this.level,
      lastStatus: lastStatus ?? this.lastStatus,
      localeNames: localeNames ?? this.localeNames,
      systemLocale: systemLocale ?? this.systemLocale,
      lastFailure: lastFailure ?? this.lastFailure,
      currentOptions: currentOptions ?? this.currentOptions,
    );
  }

  SttState resetSystemLocal() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      speechRecognitionResult: speechRecognitionResult,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: null,
      lastFailure: lastFailure,
      currentOptions: currentOptions,
    );
  }

  SttState resetFailure() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      speechRecognitionResult: speechRecognitionResult,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: systemLocale,
      lastFailure: null,
      currentOptions: currentOptions,
    );
  }

  SttState resetCurrentOptions() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      speechRecognitionResult: speechRecognitionResult,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: systemLocale,
      lastFailure: lastFailure,
      currentOptions: null,
    );
  }

  SttState resetSpeechRecognitionResult() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      speechRecognitionResult: null,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: systemLocale,
      lastFailure: lastFailure,
      currentOptions: currentOptions,
    );
  }
}
