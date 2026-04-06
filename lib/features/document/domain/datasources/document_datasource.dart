import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class DocumentRemoteDataSource extends BaseRepository {
  Future<Either<Failure, DocumentResponse>> getDocument(UserToken? token, GetDocumentPayload getDocumentPayload) async {
    LoggerService.logDebug('DocumentRemoteDataSource -> getDocument()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;

    final result = await makeRequest(
      () => DocumentApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getDocumentApiGetDocumentPost(getDocumentPayload),
    );
    return result.fold(
      (failure) => Left(failure),
      (document) => document == null ? Left(CommonFailure(message: getDocumentPayload.documentId)) : Right(document),
    );
  }
}
