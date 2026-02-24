import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class IdocItRemoteDataSource {
  Future<Either<Failure, List<ChatSummary>>> getChats(UserToken? token) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final chats =
          (await ChatApi(
            ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
          ).listChatsApiChatsGet(limit: 500, offset: 0))?.items ??
          [];
      return Right(chats);
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, Null>> deleteChat(UserToken? token, {required String chatId}) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final result = await ChatApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).deleteChatApiChatsChatIdDelete(chatId);
      return result != null && result.status == 'ok' ? Right(null) : Left(NetworkFailure());
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
