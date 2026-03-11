part of 'stt_bloc.dart';

class SttState {
  final bool isEnabled;
  final bool isStarted;
  final bool finalResult;
  final String lastWords;
  final SpeechRecognitionError? lastError;
  final double level;
  final String lastStatus;
  final List<LocaleName> localeNames;
  final LocaleName? systemLocale;
  const SttState({
    required this.isEnabled,
    required this.isStarted,
    required this.finalResult,
    required this.lastWords,
    required this.lastError,
    required this.level,
    required this.lastStatus,
    required this.localeNames,
    required this.systemLocale,
  });

  factory SttState.initial() {
    return const SttState(
      isEnabled: false,
      isStarted: false,
      finalResult: false,
      lastWords: '',
      lastError: null,
      level: 0.0,
      lastStatus: '',
      localeNames: [],
      systemLocale: null,
    );
  }

  SttState update({
    bool? isEnabled,
    bool? isStarted,
    bool? finalResult,
    String? lastWords,
    SpeechRecognitionError? lastError,
    double? level,
    String? lastStatus,
    List<LocaleName>? localeNames,
    LocaleName? systemLocale,
  }) {
    return SttState(
      isEnabled: isEnabled ?? this.isEnabled,
      isStarted: isStarted ?? this.isStarted,
      finalResult: finalResult ?? this.finalResult,
      lastWords: lastWords ?? this.lastWords,
      lastError: lastError ?? this.lastError,
      level: level ?? this.level,
      lastStatus: lastStatus ?? this.lastStatus,
      localeNames: localeNames ?? this.localeNames,
      systemLocale: systemLocale ?? this.systemLocale,
    );
  }

  SttState resetLatError() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      finalResult: finalResult,
      lastWords: lastWords,
      lastError: null,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: systemLocale,
    );
  }

  SttState resetSystemLocal() {
    return SttState(
      isEnabled: isEnabled,
      isStarted: isStarted,
      finalResult: finalResult,
      lastWords: lastWords,
      lastError: lastError,
      level: level,
      lastStatus: lastStatus,
      localeNames: localeNames,
      systemLocale: null,
    );
  }
}
