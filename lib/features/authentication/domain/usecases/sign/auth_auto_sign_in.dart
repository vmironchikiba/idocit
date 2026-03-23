import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/firebase.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_secure_storage.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_in.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthAutoSignIn implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final AuthGetUserData authGetUserData;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthUpdateStatus authUpdateStatus;
  final AuthSecureStorage authSecureStorage;
  final AuthSignIn authSignIn;
  final firebase = locator<FirebaseService>();
  AuthAutoSignIn({
    required this.networkListenerService,
    required this.authBloc,
    required this.authGetUserData,
    required this.authRemoteDataSource,
    required this.authUpdateStatus,
    required this.authSecureStorage,
    required this.authSignIn,
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
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('AuthAutoSignIn -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(NoParams()))) {
      return const Left(NetworkFailure());
    }
    locator<InAppFailureProvider>().addEvent(toString());
    if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
      locator<InAppFailureProvider>().removeEvent(toString());
      return const Left(NetworkFailure());
    }

    locator<InAppFailureProvider>().removeEvent(toString());

    final token = await authSecureStorage.readTokensData();
    if (token == null) return Left(NetworkFailure());
    final refreshToken = await authRemoteDataSource.refreshTokenRequest(token.refreshToken);
    return refreshToken.fold(
      (failure) {
        return Left(NetworkFailure());
      },
      (userToken) async {
        authBloc.add(UpdateTokensDataEvent(userToken: userToken));
        Failure? userDataFailure;

        final userDataResponse = await authGetUserData.call(NoParams());
        userDataResponse.fold(
          (failure) {
            userDataFailure = failure;
          },
          (result) {
            authBloc.add(UpdateUserDataEvent(userData: result));
            _updateFirebase(result: result);
            _logEvent(name: 'auto-sign-in', result: result);
          },
        );

        if (userDataFailure != null) {
          return Left(userDataFailure!);
        }

        authSecureStorage.writeTokensData(userToken);
        authUpdateStatus.call(AuthType.authenticated);

        return const Right(null);
      },
    );
  }
}
