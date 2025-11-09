import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/date_time.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'components_events.dart';
part 'components_state.dart';

class ComponentsBloc extends Bloc<ComponentsBlocEvent, ComponentsState> {
  ComponentsBloc(super.initialState) {
    on<SetUpdatedDateEvent>((event, emit) {
      emit(state.update(updated: event.date));
    });

    on<SetComponentConfigEvent>((event, emit) {
      emit(state.update(componentConfig: event.componentConfig));
    });

    on<ResetComponentConfigEvent>((event, emit) {
      emit(state.update(componentConfig: null));
    });
  }

  @override
  void onEvent(ComponentsBlocEvent event) {
    super.onEvent(event);
    LoggerService.logDebug('IdocItBloc -> onEvent(): ${event.runtimeType}');
  }
}
