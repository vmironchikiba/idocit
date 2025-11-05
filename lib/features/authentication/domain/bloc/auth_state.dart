part of 'auth_bloc.dart';

enum AuthType { unauthenticated, authenticated }

class AuthState {
  final KeycloakUser? userData;
  final UserToken? userToken;
  final SignUpData signUpData;
  final AuthType authType;

  const AuthState({required this.userData, required this.userToken, required this.signUpData, required this.authType});

  factory AuthState.initial() {
    return const AuthState(
      userData: null,
      userToken: null,
      signUpData: SignUpData(),
      authType: AuthType.unauthenticated,
    );
  }

  AuthState clearAdditionalData() {
    return AuthState(
      userData: userData,
      userToken: userToken,
      signUpData: const SignUpData(),
      authType: AuthType.authenticated,
    );
  }

  AuthState update({KeycloakUser? userData, UserToken? userToken, SignUpData? signUpData, AuthType? authType}) {
    return AuthState(
      userData: userData ?? this.userData,
      userToken: userToken ?? this.userToken,
      signUpData: signUpData ?? this.signUpData,
      authType: authType ?? this.authType,
    );
  }
}
