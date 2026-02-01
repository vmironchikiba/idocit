import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/authentication/domain/models/sign_up_data.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'auth_events.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<UpdateUserDataEvent>((event, emit) {
      emit(state.update(userData: event.userData));
    });

    on<UpdateTokensDataEvent>((event, emit) {
      emit(state.update(userToken: event.userToken));
    });

    // on<UpdateSignUpDataEvent>((event, emit) {
    //   emit(state.update(signUpData: event.signUpData));
    // });

    on<UpdateAuthStatusEvent>((event, emit) {
      emit(state.update(authType: event.authType));
    });

    on<ClearAdditionalDataAuthEvent>((event, emit) {
      emit(state.clearAdditionalData());
    });

    on<LogOutAuthEvent>((event, emit) {
      emit(AuthState.initial());
    });

    // on<SignOutAuthEvent>((event, emit) {
    //   emit(AuthState.initial());
    // });
  }

  @override
  void onEvent(AuthBlocEvent event) {
    super.onEvent(event);
    // LoggerService.logDebug('AuthBloc -> onEvent(): ${event.runtimeType}');
  }
}
