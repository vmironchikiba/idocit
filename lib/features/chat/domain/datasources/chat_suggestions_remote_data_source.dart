import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatSuggestionsRemoteDataSource extends BaseRepository {
  Future<Either<Failure, SuggestionsResponse?>> getSuggestions(UserToken? token, String query) async {
    LoggerService.logDebug('SuggestionsResponse -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => SuggestionsApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).suggestionsApiSuggestionsPost(QueryPayload(query: query)),
    );
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(CommonFailure(message: query)) : Right(response),
    );
  }
}
