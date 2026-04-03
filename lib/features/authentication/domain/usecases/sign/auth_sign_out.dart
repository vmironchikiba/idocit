import 'package:dartz/dartz.dart';
import 'package:idocit/common/services/firebase.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_secure_storage.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthSignOut implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthSecureStorage authSecureStorage;
  final AuthUpdateStatus authUpdateStatus;
  final firebase = locator<FirebaseService>();

  AuthSignOut({
    required this.networkListenerService,
    required this.authBloc,
    required this.authRemoteDataSource,
    required this.authSecureStorage,
    required this.authUpdateStatus,
  });

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
  Future<Either<Failure, void>> call(NoParams data, {bool withStatusUpdate = true}) async {
    LoggerService.logDebug('AuthSignIn -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(data, withStatusUpdate: withStatusUpdate))) {
      return const Left(NetworkFailure());
    }

    final refreshToken = authBloc.state.userToken?.refreshToken;
    if (refreshToken == null) {
      return const Left(NetworkFailure());
    }
    final logoutRequest = LogoutRequest(refreshToken: refreshToken);
    final response = await authRemoteDataSource.signOut(logoutRequest);
    return response.fold(
      (failure) {
        LoggerService.logDebug('FAILURE: AuthSignIn: authRemoteDataSource.signIn()');
        LoggerService.logDebug('FAILURE: ${failure.message}');
        return Left(failure);
      },
      (result) async {
        authBloc.add(LogOutAuthEvent());

        await authSecureStorage.deleteTokensData();
        if (withStatusUpdate) {
          authUpdateStatus.call(AuthType.unauthenticated);
        }
        final userData = locator<AuthBloc>().state.userData;
        if (userData != null) {
          _logEvent(name: 'sign-out', result: userData);
        }
        return const Right(null);
      },
    );
  }
}
