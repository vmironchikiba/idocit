import 'package:dartz/dartz.dart';
import 'package:idocit/common/services/firebase.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_secure_storage.dart';
import 'package:idocit/features/authentication/domain/models/login_data.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthSignIn implements UseCase<Either<Failure, void>, BodyLoginApiLoginPost> {
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthSecureStorage authSecureStorage;
  final AuthGetUserData authGetUserData;
  final AuthUpdateStatus authUpdateStatus;
  final firebase = locator<FirebaseService>();

  AuthSignIn({
    required this.networkListenerService,
    required this.authBloc,
    required this.authRemoteDataSource,
    required this.authSecureStorage,
    required this.authGetUserData,
    required this.authUpdateStatus,
  });

  void _updateFirebase({required KeycloakUser result}) {
    firebase.setUserId(result.id);
    firebase.setUserProperty(name: 'username', value: result.username);
    firebase.setUserProperty(name: 'email', value: result.email);
    firebase.setUserProperty(name: 'role', value: result.role);
    firebase.setUserProperty(name: 'tenant', value: result.tenant);
  }

  void _logEvent({required String name, required KeycloakUser result}) => firebase.logFirebaseEvent(
    name: name,
    parameters: {
      'id': result.id,
      'username': result.username,
      'email': result.email,
      'role': result.role,
      'tenant': result.tenant,
    },
  );

  @override
  Future<Either<Failure, void>> call(BodyLoginApiLoginPost data, {bool withStatusUpdate = true}) async {
    LoggerService.logDebug('AuthSignIn -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(data, withStatusUpdate: withStatusUpdate))) {
      return const Left(NetworkFailure());
    }

    final response = await authRemoteDataSource.signIn(data);

    return response.fold(
      (failure) async {
        LoggerService.logDebug('FAILURE: AuthSignIn: authRemoteDataSource.signIn()');
        LoggerService.logDebug('FAILURE: ${failure.message}');
        if (failure is TokenExpiredFailure) {
          final response = await authRemoteDataSource.refreshTokenRequest(authBloc.state.userToken?.refreshToken);
          return response.fold(
            (failure) {
              return Left(failure);
            },
            (result) async {
              authBloc.add(UpdateTokensDataEvent(userToken: result));
              // KeycloakUser? userData;
              Failure? userDataFailure;

              final userDataResponse = await authGetUserData.call(NoParams());
              userDataResponse.fold(
                (failure) {
                  userDataFailure = failure;
                },
                (result) {
                  authBloc.add(UpdateUserDataEvent(userData: result));
                  _updateFirebase(result: result);
                  _logEvent(name: 'sign-in-refresh', result: result);
                },
              );

              if (userDataFailure != null) {
                return Left(userDataFailure!);
              }

              authSecureStorage.writeTokensData(result);
              if (withStatusUpdate) {
                authUpdateStatus.call(AuthType.authenticated);
              }

              return const Right(null);
            },
          );
        }

        // if (failure is HTTPFailure && failure.type == HttpErrorType.userNotConfirmed) {
        //   return Left(AuthErrorType.needConfirmEmail.convertToFailure());
        // }

        return Left(failure);
      },
      (result) async {
        authBloc.add(UpdateTokensDataEvent(userToken: result));
        // KeycloakUser? userData;
        Failure? userDataFailure;

        final userDataResponse = await authGetUserData.call(NoParams());
        userDataResponse.fold(
          (failure) {
            LoggerService.logDebug('FAILURE: AuthSignIn: authGetUserData.call()');
            LoggerService.logDebug('FAILURE: ${failure.message}');
            userDataFailure = failure;
          },
          (result) {
            authBloc.add(UpdateUserDataEvent(userData: result));
            _updateFirebase(result: result);
            _logEvent(name: 'sign-in', result: result);
            // userData = result;
          },
        );

        if (userDataFailure != null) {
          return Left(userDataFailure!);
        }

        // if (!userData!.isConfirmed) {
        //   authBloc.add(
        //     UpdateSignUpDataEvent(
        //       signUpData: SignUpData(
        //         id: userData!.id,
        //         email: data.email,
        //         password: data.password,
        //       ),
        //     ),
        //   );

        //   return Left(AuthErrorType.needConfirmPersonalData.convertToFailure());
        // }

        authSecureStorage.writeTokensData(result);

        // final homesResponse = await userGetAllHomes.call(NoParams());
        // return homesResponse.fold(
        //   (failure) {
        //     LoggerService.logDebug('FAILURE: AuthSignIn: authRemoteDataSource.signIn()');
        //     LoggerService.logDebug('FAILURE: ${failure.message}');

        //     if (failure is HTTPFailure && failure.type == HttpErrorType.userNotConfirmed) {
        //       return Left(AuthErrorType.needConfirmEmail.convertToFailure());
        //     }

        //     if (failure is AuthFailure && failure.type == AuthErrorType.needConfirmHome) {
        //       return Left(failure);
        //     }

        //     return Left(failure);
        //   },
        //   (result) async {
        if (withStatusUpdate) {
          authUpdateStatus.call(AuthType.authenticated);
        }

        return const Right(null);
        //   },
        // );
      },
    );
  }
}
