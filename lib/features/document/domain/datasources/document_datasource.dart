import 'package:dartz/dartz.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class DocumentRemoteDataSource {
  // Future<Either<Failure, List<ChatSummary>>> getChats(UserToken? token, String chatId) async {
  Future<Either<Failure, DocumentResponse>> getDocument(UserToken? token, GetDocumentPayload getDocumentPayload) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final document = (await DocumentApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getDocumentApiGetDocumentPost(getDocumentPayload));
      return document == null ? Left(NetworkFailure()) : Right(document);
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
