part of 'presets_bloc.dart';

abstract class PresetsBlocEvent {
  const PresetsBlocEvent([List props = const []]) : super();
}

class UpdatePresetsEvent extends PresetsBlocEvent {
  final Object? presets;

  UpdatePresetsEvent({required this.presets}) : super([presets]);
}

class ClearPresetsEvent extends PresetsBlocEvent {
  ClearPresetsEvent() : super();
}

class LogOutAuthEvent extends PresetsBlocEvent {
  LogOutAuthEvent() : super();
}
