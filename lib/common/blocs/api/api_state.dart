part of 'api_bloc.dart';

class ApiState {
  final AuthApi? authApi;
  final UsersApi? usersApi;
  final UserToken? userToken;
  const ApiState({required this.authApi, required this.usersApi, required this.userToken});
  factory ApiState.initial() {
    return const ApiState(authApi: null, usersApi: null, userToken: null);
  }

  ApiState update({AuthApi? authApi, UsersApi? usersApi, UserToken? userToken}) {
    return ApiState(
      authApi: authApi ?? this.authApi,
      usersApi: usersApi ?? this.usersApi,
      userToken: userToken ?? this.userToken,
    );
  }
}
