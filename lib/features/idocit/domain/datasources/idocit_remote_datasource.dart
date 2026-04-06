import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class IdocItRemoteDataSource extends BaseRepository {
  Future<Either<Failure, List<ChatSummary>>> getChats(UserToken? token) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => ChatApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).listChatsApiChatsGet(limit: 500, offset: 0),
    );
    return result.fold((failure) => Left(failure), (response) => Right(response?.items ?? []));
  }

  Future<Either<Failure, Null>> deleteChat(UserToken? token, {required String chatId}) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => ChatApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).deleteChatApiChatsChatIdDelete(chatId),
    );
    return result.fold(
      (failure) => Left(failure),
      (success) => success != null && success.status == 'ok'
          ? Right(null)
          : Left(CommonFailure(message: success?.status ?? chatId)),
    );
  }
}
