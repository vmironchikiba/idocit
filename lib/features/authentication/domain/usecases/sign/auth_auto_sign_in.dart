import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
// import 'package:idocit/features/authentication/domain/usecases/auth_refresh_tokens.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
// import 'package:idocit/features/multi_houses/domain/usecases/user_get_all_homes.dart';

class AuthAutoSignIn implements UseCase<Either<Failure, void>, NoParams> {
  final AuthBloc authBloc;
  final AuthGetUserData authGetUserData;
  // final AuthRefreshTokens authRefreshTokens;
  final AuthUpdateStatus authUpdateStatus;
  // final UserGetAllHomes userGetAllHomes;

  const AuthAutoSignIn({
    required this.authBloc,
    required this.authGetUserData,
    // required this.authRefreshTokens,
    required this.authUpdateStatus,
    // required this.userGetAllHomes,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('AuthAutoSignIn -> call()');
    return Right(null);
    // final response = await authRefreshTokens.call(null);
    // return response.fold(
    //   (failure) {
    //     LoggerService.logDebug('FAILURE: AuthAutoSignIn: authRefreshTokens.call()');
    //     LoggerService.logDebug('FAILURE: ${failure.message}');
    //     return Left(failure);
    //   },
    //   (result) async {
    //     final authResponse = await _getUserAttributes();
    //     return authResponse.fold(
    //       (failure) {
    //         LoggerService.logDebug('FAILURE: AuthAutoSignIn: _getUserAttributes()');
    //         LoggerService.logDebug('FAILURE: ${failure.message}');
    //         return Left(failure);
    //       },
    //       (result) {
    //         return const Right(null);
    //       },
    //     );
    //   },
    // );
  }

  Future<Either<Failure, void>> _getUserAttributes() async {
    final response = await authGetUserData.call(NoParams());
    return response.fold(
      (failure) {
        LoggerService.logDebug('FAILURE: AuthAutoSignIn: authGetUserData.call()');
        LoggerService.logDebug('FAILURE: ${failure.message}');
        return Left(failure);
      },
      (result) async {
        // authBloc.add(UpdateUserDataEvent(userData: result));

        // final homesResponse = await userGetAllHomes.call(NoParams());
        // homesResponse.fold(
        //   (failure) {
        //     LoggerService.logDebug('FAILURE: AuthAutoSignIn: userGetAllHomes.call()');
        //     LoggerService.logDebug('FAILURE: ${failure.message}');

        //     if (failure is HTTPFailure && failure.type == HttpErrorType.userNotConfirmed) {
        //       return Left(AuthErrorType.needConfirmEmail.convertToFailure());
        //     }
        //     return Left(failure);
        //   },
        //   (result) async {
        //     authUpdateStatus.call(AuthType.authenticated);
        //     return const Right(null);
        //   },
        // );

        return const Right(null);
      },
    );
  }
}
