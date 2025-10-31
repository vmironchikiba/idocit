import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/models/user_data.dart';

class AuthGetUserData implements UseCase<Either<Failure, UserData>, NoParams> {
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthGetUserData({
    required this.networkListenerService,
    required this.authBloc,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserData>> call(NoParams params) async {
    LoggerService.logDebug('AuthGetUserData -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
      return const Left(NetworkFailure());
    }

    final userData = UserData(
      id: 'id',
      email: 'email',
      username: 'username',
      address: 'address',
      firstName: 'firstName',
      lastName: 'lastName',
      phoneNumber: 'phoneNumber',
      creationDate: DateTime.now(),
      isEmailVerified: true,
      isPhoneNumberVerified: true,
    );
    return Right(userData);
    // final response = await authRemoteDataSource.getUserAttributes();
    // return response.fold(
    //   (failure) async {
    //     LoggerService.logDebug('FAILURE: AuthGetUserData: authRemoteDataSource.getUserAttributes()');
    //     LoggerService.logDebug('FAILURE: ${failure.message}');
    //     return Left(failure);
    //   },
    //   (result) async {
    //     authBloc.add(UpdateUserDataEvent(userData: result));
    //     return Right(result);
    //   },
    // );
  }
}
