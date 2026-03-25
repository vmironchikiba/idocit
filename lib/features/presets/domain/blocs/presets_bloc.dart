import 'package:flutter_bloc/flutter_bloc.dart';

part 'presets_events.dart';
part 'presets_state.dart';

class PresetsBloc extends Bloc<PresetsBlocEvent, PresetsState> {
  PresetsBloc(super.initialState) {
    on<UpdatePresetsEvent>((event, emit) {
      emit(event.presets != null ? state.update(presets: event.presets) : state.clearPresets());
    });

    on<LogOutAuthEvent>((event, emit) {
      emit(PresetsState.initial());
    });
  }

  @override
  void onEvent(PresetsBlocEvent event) {
    super.onEvent(event);
    // LoggerService.logDebug('AuthBloc -> onEvent(): ${event.runtimeType}');
  }
}
