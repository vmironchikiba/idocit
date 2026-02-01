import 'package:dartz/dartz.dart';
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

class AuthSignIn implements UseCase<Either<Failure, void>, LoginData> {
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthSecureStorage authSecureStorage;
  final AuthGetUserData authGetUserData;
  final AuthUpdateStatus authUpdateStatus;

  const AuthSignIn({
    required this.networkListenerService,
    required this.authBloc,
    required this.authRemoteDataSource,
    required this.authSecureStorage,
    required this.authGetUserData,
    required this.authUpdateStatus,
  });

  @override
  Future<Either<Failure, void>> call(LoginData data, {bool withStatusUpdate = true}) async {
    LoggerService.logDebug('AuthSignIn -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(data, withStatusUpdate: withStatusUpdate))) {
      return const Left(NetworkFailure());
    }

    final response = await authRemoteDataSource.signIn(data);
    return response.fold(
      (failure) {
        LoggerService.logDebug('FAILURE: AuthSignIn: authRemoteDataSource.signIn()');
        LoggerService.logDebug('FAILURE: ${failure.message}');

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
