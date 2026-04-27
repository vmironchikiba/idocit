import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class AuthRemoteDataSource extends BaseRepository {
  // UserToken? token;
  Future<Either<Failure, UserToken>> signIn(BodyLoginApiLoginPost data) async {
    LoggerService.logDebug('AuthRemoteDataSource -> signIn(email: ${data.username})');
    final result = await makeRequest(() => locator<AuthApi>().loginApiLoginPost(data));
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(UnautorizedFailure()) : Right(response),
    );
  }

  Future<Either<Failure, UserToken>> refreshTokenRequest(String? refreshToken) async {
    LoggerService.logDebug('AuthRemoteDataSource -> refreshTokenRequest(refreshToken: $refreshToken)');
    final result = await makeRequest(
      () => locator<AuthApi>().refreshApiTokenRefreshPost(
        refreshTokenRequest: RefreshTokenRequest(refreshToken: refreshToken),
      ),
    );
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(UnautorizedFailure()) : Right(response),
    );
  }

  Future<Either<Failure, String>> signOut(LogoutRequest data) async {
    LoggerService.logDebug('AuthRemoteDataSource -> signOut(refreshToken: ${data.refreshToken})');
    final result = await makeRequest(() => locator<AuthApi>().logoutApiLogoutPost(data));
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(CommonFailure(message: data.refreshToken)) : Right(response),
    );
  }

  Future<Either<Failure, KeycloakUser>> getUserAttributes(UserToken? token) async {
    LoggerService.logDebug('AuthRemoteDataSource -> getUserAttributes()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => UsersApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).readCurrentUserApiUsersMeGet(),
    );
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(CommonFailure(message: token.tokenType)) : Right(response),
    );
  }
}
