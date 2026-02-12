import 'package:dartz/dartz.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatSuggestionsRemoteDataSource {
  Future<Either<Failure, SuggestionsResponse?>> getSuggestions(UserToken? token, String query) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final suggestionsResponse = await SuggestionsApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).suggestionsApiSuggestionsPost(QueryPayload(query: query));
      return Right(suggestionsResponse);
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
