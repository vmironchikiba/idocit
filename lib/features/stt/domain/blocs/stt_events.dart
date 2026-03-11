part of 'stt_bloc.dart';

abstract class SttBlocEvent {
  const SttBlocEvent([List props = const []]) : super();
}

class UpdateSttIsEnabled extends SttBlocEvent {
  final bool isEnabled;
  UpdateSttIsEnabled({required this.isEnabled}) : super([isEnabled]);
}

class UpdateSttIsStarted extends SttBlocEvent {
  final bool isStarted;
  UpdateSttIsStarted({required this.isStarted}) : super([isStarted]);
}

class UpdateSttFinalResult extends SttBlocEvent {
  final bool finalResult;
  UpdateSttFinalResult({required this.finalResult}) : super([finalResult]);
}

class UpdateSttLastWords extends SttBlocEvent {
  final String lastWords;
  UpdateSttLastWords({required this.lastWords}) : super([lastWords]);
}

class UpdateSttLevel extends SttBlocEvent {
  final double level;
  UpdateSttLevel({required this.level}) : super([level]);
}

class UpdateSttLastStatus extends SttBlocEvent {
  final String lastStatus;
  UpdateSttLastStatus({required this.lastStatus}) : super([lastStatus]);
}

class UpdateSttLocalNames extends SttBlocEvent {
  final List<LocaleName> localeNames;
  UpdateSttLocalNames({required this.localeNames}) : super([localeNames]);
}

class UpdateSttSystemLocale extends SttBlocEvent {
  final LocaleName? systemLocale;
  UpdateSttSystemLocale({required this.systemLocale}) : super([systemLocale]);
}

class UpdateSttLastFailure extends SttBlocEvent {
  final SttSpeechFailure? lastFailure;
  UpdateSttLastFailure({required this.lastFailure}) : super([lastFailure]);
}

class SignOutCoreEvent extends SttBlocEvent {
  SignOutCoreEvent() : super();
}
