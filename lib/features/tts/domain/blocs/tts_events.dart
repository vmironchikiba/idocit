part of 'tts_bloc.dart';

abstract class TtsBlocEvent {
  const TtsBlocEvent([List props = const []]) : super();
}

class UpdateTtsState extends TtsBlocEvent {
  final TtsStateEnum ttsState;
  UpdateTtsState({required this.ttsState}) : super([ttsState]);
}

class UpdateTtsVolume extends TtsBlocEvent {
  final double volume;
  UpdateTtsVolume({required this.volume}) : super([volume]);
}

class UpdateTtsPitch extends TtsBlocEvent {
  final double pitch;
  UpdateTtsPitch({required this.pitch}) : super([pitch]);
}

class UpdateTtsRate extends TtsBlocEvent {
  final double rate;
  UpdateTtsRate({required this.rate}) : super([rate]);
}

class UpdateTtsLanguages extends TtsBlocEvent {
  final List<String> languages;
  UpdateTtsLanguages({required this.languages}) : super([languages]);
}

class UpdateTtsEngines extends TtsBlocEvent {
  final List<String> engines;
  UpdateTtsEngines({required this.engines}) : super([engines]);
}

class UpdateTtsVoices extends TtsBlocEvent {
  final List<Map<String, String>> voices;
  UpdateTtsVoices({required this.voices}) : super([voices]);
}

class UpdateTtsVoiceText extends TtsBlocEvent {
  final String? voiceText;
  UpdateTtsVoiceText({required this.voiceText}) : super([voiceText]);
}

class SignOutCoreEvent extends TtsBlocEvent {
  SignOutCoreEvent() : super();
}
