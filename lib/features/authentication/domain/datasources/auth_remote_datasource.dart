import 'package:dartz/dartz.dart';
import 'package:idocit/features/authentication/domain/models/login_data.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthRemoteDataSource {
  UserToken? token;
  Future<Either<Failure, UserToken>> signIn(LoginData data) async {
    LoggerService.logDebug('AuthRemoteDataSource -> signIn(email: ${data.email})');
    try {
      final result = await locator<AuthApi>().loginApiLoginPost(data.email, data.password);
      token = result;
      return result == null ? Left(NetworkFailure()) : Right(result);
    } catch (exception) {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, KeycloakUser>> getUserAttributes() async {
    LoggerService.logDebug('AuthRemoteDataSource -> getUserAttributes()})');
    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token?.accessToken ?? '';
      final client = ApiClient(basePath: 'https://ai-assistant.ibagroupit.com/idocit', authentication: authentication);
      final user = await UsersApi(client).readCurrentUserApiUsersMeGet();
      // final user = await locator<UsersApi>().readCurrentUserApiUsersMeGet();
      if (user != null) {
        return Right(user);
      } else {
        return Left(NetworkFailure());
      }
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
