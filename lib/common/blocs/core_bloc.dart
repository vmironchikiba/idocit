import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/in_app_toast_data.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'core_events.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreBlocEvent, CoreState> {
  CoreBloc(super.initialState) {
    on<UpdateInAppToastEvent>((event, emit) {
      emit(state.updateInfoMessage(infoMessage: event.inAppToastData));
    });
    on<UpdateScreenLock>((event, emit) {
      emit(state.updateInfoMessage(screenLock: event.screenLock));
    });
    on<SignOutCoreEvent>((event, emit) {
      emit(CoreState.initial());
    });
  }

  @override
  void onEvent(CoreBlocEvent event) {
    super.onEvent(event);
  }
}
