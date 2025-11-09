import 'package:dartz/dartz.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/features/authentication/domain/models/login_data.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthRemoteDataSource {
  // UserToken? token;
  Future<Either<Failure, UserToken>> signIn(LoginData data) async {
    LoggerService.logDebug('AuthRemoteDataSource -> signIn(email: ${data.email})');
    try {
      final result = await locator<AuthApi>().loginApiLoginPost(data.email, data.password);
      return result != null ? Right(result) : Left(NetworkFailure());
    } catch (exception) {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, KeycloakUser>> getUserAttributes(UserToken? token) async {
    LoggerService.logDebug('AuthRemoteDataSource -> getUserAttributes()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final user = await UsersApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).readCurrentUserApiUsersMeGet();
      return user != null ? Right(user) : Left(NetworkFailure());
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
