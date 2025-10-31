part of 'auth_bloc.dart';

abstract class AuthBlocEvent {
  const AuthBlocEvent([List props = const []]) : super();
}

class UpdateTokensDataEvent extends AuthBlocEvent {
  final UserToken userToken;

  UpdateTokensDataEvent({required this.userToken}) : super([userToken]);
}

class UpdateAuthStatusEvent extends AuthBlocEvent {
  final AuthType authType;

  UpdateAuthStatusEvent({required this.authType}) : super([authType]);
}

class ClearAdditionalDataAuthEvent extends AuthBlocEvent {
  ClearAdditionalDataAuthEvent() : super();
}
