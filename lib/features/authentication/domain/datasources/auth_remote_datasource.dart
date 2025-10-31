import 'package:dartz/dartz.dart';
import 'package:idocit/features/authentication/domain/models/login_data.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthRemoteDataSource {
  Future<Either<Failure, UserToken>> signIn(LoginData data) async {
    LoggerService.logDebug('AuthRemoteDataSource -> signIn(email: ${data.email})');
    try {
      final result = await locator<AuthApi>().loginApiLoginPost(data.email, data.password);
      return result == null ? Left(NetworkFailure()) : Right(result);
    } catch (exception) {
      return Left(NetworkFailure());
    }
  }
}
