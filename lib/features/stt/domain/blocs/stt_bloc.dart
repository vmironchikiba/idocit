import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'stt_events.dart';
part 'stt_state.dart';

class SttBloc extends Bloc<SttBlocEvent, SttState> {
  SttBloc(super.initialState) {
    on<UpdateSttIsEnabled>((event, emit) {
      emit(state.update(isEnabled: event.isEnabled));
    });

    on<UpdateSttIsStarted>((event, emit) {
      emit(state.update(isStarted: event.isStarted));
    });

    on<UpdateSttFinalResult>((event, emit) {
      emit(state.update(finalResult: event.finalResult));
    });

    on<UpdateSttLastWords>((event, emit) {
      emit(state.update(lastWords: event.lastWords));
    });

    on<UpdateSttLastFailure>((event, emit) {
      emit(event.lastFailure == null ? state.resetFailure() : state.update(lastFailure: event.lastFailure));
    });

    on<UpdateSttLevel>((event, emit) {
      emit(state.update(level: event.level));
    });

    on<UpdateSttLastStatus>((event, emit) {
      emit(state.update(lastStatus: event.lastStatus));
    });

    on<UpdateSttLocalNames>((event, emit) {
      emit(state.update(localeNames: event.localeNames));
    });

    on<UpdateSttSystemLocale>((event, emit) {
      emit(event.systemLocale == null ? state.resetSystemLocal() : state.update(systemLocale: event.systemLocale));
    });

    on<SignOutCoreEvent>((event, emit) {
      emit(SttState.initial());
    });
  }

  @override
  void onEvent(SttBlocEvent event) {
    super.onEvent(event);
  }
}
