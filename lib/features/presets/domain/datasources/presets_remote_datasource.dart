import 'package:dartz/dartz.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class PresetsRemoteDataSource {
  Future<Either<Failure, Object?>> getAllPresets(UserToken? token) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final componentConfig = (await PresetApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getAllPresetsApiPresetsGet());
      if (componentConfig == null) return Left(NetworkFailure());
      return Right(componentConfig);
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
