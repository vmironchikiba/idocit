part of 'tts_bloc.dart';

abstract class TtsBlocEvent {
  const TtsBlocEvent([List props = const []]) : super();
}

class UpdateTtsIsEnabled extends TtsBlocEvent {
  final bool isEnabled;
  UpdateTtsIsEnabled({required this.isEnabled}) : super([isEnabled]);
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
  final List<TtsLanguage> languages;
  UpdateTtsLanguages({required this.languages}) : super([languages]);
}

class UpdateTtsEngines extends TtsBlocEvent {
  final List<TtsEngine> engines;
  UpdateTtsEngines({required this.engines}) : super([engines]);
}

class UpdateTtsVoices extends TtsBlocEvent {
  final List<TtsVoice> voices;
  UpdateTtsVoices({required this.voices}) : super([voices]);
}

class UpdateTtsDefaultEngine extends TtsBlocEvent {
  final TtsEngine defaultEngine;
  UpdateTtsDefaultEngine({required this.defaultEngine}) : super([defaultEngine]);
}

class UpdateTtsCurrentEngine extends TtsBlocEvent {
  final TtsEngine? currentEngine;
  UpdateTtsCurrentEngine({required this.currentEngine}) : super([currentEngine]);
}

class UpdateTtsDefaultVoice extends TtsBlocEvent {
  final TtsVoice defaultVoice;
  UpdateTtsDefaultVoice({required this.defaultVoice}) : super([defaultVoice]);
}

class UpdateTtsCurrentVoice extends TtsBlocEvent {
  final TtsVoice? currentVoice;
  UpdateTtsCurrentVoice({required this.currentVoice}) : super([currentVoice]);
}

class UpdateTtsVoiceText extends TtsBlocEvent {
  final String? voiceText;
  UpdateTtsVoiceText({required this.voiceText}) : super([voiceText]);
}

class SignOutCoreEvent extends TtsBlocEvent {
  SignOutCoreEvent() : super();
}
