import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/date_time.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'idocit_events.dart';
part 'idocit_state.dart';

class IdocItBloc extends Bloc<IdocItBlocEvent, IdocItState> {
  IdocItBloc(super.initialState) {
    on<SetSelectedDateEvent>((event, emit) {
      emit(state.update(selectedDate: event.date));
    });

    on<SetChatsEvent>((event, emit) {
      emit(state.update(chats: event.chats));
    });

    on<SignOutIdocItEvent>((event, emit) {
      emit(IdocItState.initial());
    });
  }

  @override
  void onEvent(IdocItBlocEvent event) {
    super.onEvent(event);
    LoggerService.logDebug('IdocItBloc -> onEvent(): ${event.runtimeType}');
  }
}
