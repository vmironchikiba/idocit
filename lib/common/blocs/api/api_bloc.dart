import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'api_events.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiBlocEvent, ApiState> {
  ApiBloc(super.initialState) {
    on<ApiUpdateUserToken>((event, emit) {
      emit(state.update(userToken: event.userToken));
    });
  }

  @override
  void onEvent(ApiBlocEvent event) {
    super.onEvent(event);
  }
}
