import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/in_app_toast_data.dart';

part 'core_events.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreBlocEvent, CoreState> {
  CoreBloc(CoreState initialState) : super(initialState) {
    on<UpdateInAppToastEvent>((event, emit) {
      emit(state.updateInfoMessage(infoMessage: event.inAppToastData));
    });
  }

  @override
  void onEvent(CoreBlocEvent event) {
    super.onEvent(event);
  }
}
