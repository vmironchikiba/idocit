import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/base_api_handler.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatHistoryRemoteDataSource extends BaseRepository {
  // Future<Either<Failure, List<ChatSummary>>> getChats(UserToken? token, String chatId) async {
  Future<Either<Failure, List<ChatHistoryMessage>>> getChats(UserToken? token, String chatId) async {
    LoggerService.logDebug('IdocItRemoteDataSource -> getChats()})');
    if (token == null) return Left(AuthFailure(message: 'No access token', type: AuthErrorType.badTokensData));
    final authentication = HttpBearerAuth();
    authentication.accessToken = token.accessToken;
    final result = await makeRequest(
      () => ChatApi(
        ApiClient(basePath: StringsConstants.basePath, authentication: authentication),
      ).getChatApiChatsChatIdGet(chatId),
    );
    return result.fold(
      (failure) => Left(failure),
      (response) => response == null ? Left(CommonFailure(message: chatId)) : Right(response),
    );
  }
}
