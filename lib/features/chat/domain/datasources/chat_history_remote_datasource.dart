import 'package:dartz/dartz.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatHistoryRemoteDataSource {
  // Future<Either<Failure, List<ChatSummary>>> getChats(UserToken? token, String chatId) async {
  Future<Either<Failure, Object?>> getChats(UserToken? token, String chatId) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));

    try {
      final authentication = HttpBearerAuth();
      authentication.accessToken = token.accessToken;
      final chats = (await ChatApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getChatApiChatsChatIdGet(chatId));
      return Right(chats);
    } catch (ex) {
      return Left(NetworkFailure());
    }
  }
}
