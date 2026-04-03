part of 'presets_bloc.dart';

class PresetsState {
  final Object? presets;

  const PresetsState({required this.presets});

  factory PresetsState.initial() {
    return const PresetsState(presets: null);
  }

  PresetsState clearPresets() {
    return PresetsState(presets: null);
  }

  PresetsState update({Object? presets}) {
    return PresetsState(presets: presets ?? this.presets);
  }
}
