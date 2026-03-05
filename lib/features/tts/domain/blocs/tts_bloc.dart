import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/enums/tts_state_enum.dart';
import 'package:flutter/foundation.dart';

part 'tts_events.dart';
part 'tts_state.dart';

class TtsBloc extends Bloc<TtsBlocEvent, TtsState> {
  TtsBloc(super.initialState) {
    on<UpdateTtsIsEnabled>((event, emit) {
      emit(state.update(isEnabled: event.isEnabled));
    });
    on<UpdateTtsState>((event, emit) {
      emit(state.update(ttsState: event.ttsState));
    });
    on<UpdateTtsVolume>((event, emit) {
      emit(state.update(volume: event.volume));
    });
    on<UpdateTtsPitch>((event, emit) {
      emit(state.update(pitch: event.pitch));
    });
    on<UpdateTtsRate>((event, emit) {
      emit(state.update(rate: event.rate));
    });

    on<UpdateTtsEngines>((event, emit) {
      emit(state.update(engines: event.engines));
    });

    on<UpdateTtsVoices>((event, emit) {
      emit(state.update(voices: event.voices));
    });

    on<UpdateTtsDefaultEngine>((event, emit) {
      emit(state.update(defaultEngine: event.defaultEngine));
    });
    on<UpdateTtsCurrentEngine>((event, emit) {
      emit(state.update(currentEngine: event.currentEngine));
    });

    on<UpdateTtsDefaultVoice>((event, emit) {
      emit(state.update(defaultVoice: event.defaultVoice));
    });
    on<UpdateTtsCurrentVoice>((event, emit) {
      emit(state.update(currentVoice: event.currentVoice));
    });

    on<UpdateTtsLanguages>((event, emit) {
      emit(state.update(languages: event.languages));
    });

    on<UpdateTtsVoiceText>((event, emit) {
      emit(state.update(voiceText: event.voiceText));
    });

    on<SignOutCoreEvent>((event, emit) {
      emit(TtsState.initial());
    });
  }

  @override
  void onEvent(TtsBlocEvent event) {
    super.onEvent(event);
  }
}
