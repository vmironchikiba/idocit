import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/date_time.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'chat_events.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatBlocEvent, ChatState> {
  ChatBloc(super.initialState) {
    on<SetSelectedDateEvent>((event, emit) {
      emit(state.update(selectedDate: event.date));
    });

    on<SetSuggestionsResponseEvent>((event, emit) {
      emit(state.update(suggestionsResponse: event.suggestionsResponse));
    });

    on<SetQueryEvent>((event, emit) {
      emit(state.update(query: event.query));
    });

    on<SignOutIdocItEvent>((event, emit) {
      emit(ChatState.initial());
    });
  }

  @override
  void onEvent(ChatBlocEvent event) {
    super.onEvent(event);
    LoggerService.logDebug('IdocItBloc -> onEvent(): ${event.runtimeType}');
  }
}
