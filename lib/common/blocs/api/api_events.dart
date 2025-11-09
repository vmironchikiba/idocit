part of 'api_bloc.dart';

abstract class ApiBlocEvent {
  const ApiBlocEvent([List props = const []]) : super();
}

class ApiUpdateUserToken extends ApiBlocEvent {
  final UserToken? userToken;

  ApiUpdateUserToken({required this.userToken}) : super([userToken]);
}

class ApiUpdateKeycloakUser extends ApiBlocEvent {
  final KeycloakUser? keycloakUser;

  ApiUpdateKeycloakUser({required this.keycloakUser}) : super([keycloakUser]);
}
