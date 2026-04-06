import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class PresetsRemoteDataSource extends BaseRepository {
  Future<Either<Failure, PresetsResponse?>> getAllPresets(UserToken? token) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => PresetApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getAllPresetsApiPresetsGet(),
    );
    return result.fold(
      (failure) => Left(failure),
      (componentConfig) => componentConfig == null
          ? Left(CommonFailure(message: componentConfig?.toString() ?? 'componentConfig'))
          : Right(componentConfig),
    );
  }
}
