import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/api/chat_remote_datasource.dart';
import 'package:idocit/features/chat/domain/datasources/open_ai_stream_api.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatLazyInitSuggestions implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatRemoteDataSource chatRemoteDataSource;

  const ChatLazyInitSuggestions({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatMessage = ChatMessage(
      role: 'user',
      content:
          'В каком формате должна представляться информация в Единую базу данных через шлюз "электронного правительства"?',
    );
    final veraOptions = VerbaOptions(
      tenant: 'kaz_audit',
      language: 'en-US',
      chatId: 'chatcmpl-17ce01bf839b4fcda2376390fa419ea0',
      embedder: {},
      retriever: {},
      generator: {},
    );
    final request = ChatCompletionRequest(
      model: 'idocit',
      messages: [chatMessage],
      stream: true,
      extraParams: veraOptions,
    );
    OpenAIStreamApi(basePath: 'https://ai-assistant.ibagroupit.com/idocit')
        .streamChatCompletions(request, token.accessToken)
        .listen(
          (chunk) {
            LoggerService.logDebug('===============================================================');
            chunk.choices.forEach((choice) {
              LoggerService.logDebug('+++++++++++++++++++++++++++++++++++++++++++++++++++++++');
              LoggerService.logDebug(choice.toString());
            });
            LoggerService.logDebug('--------------------------------------------------------');
            final test = chunk.toString();
            if (test.contains('Спасибо за ваш вопрос.')) {
              LoggerService.logDebug('STOP');
            }
            LoggerService.logDebug(test);
            LoggerService.logDebug('.........................................................');
          },
          onError: (err) {
            LoggerService.logDebug(err.toString());
          },
          onDone: () => LoggerService.logDebug('000000000000000000000000000000000000000000000000000'),
        );
    final chatsResult = await chatRemoteDataSource.getSuggestions(token, '');
    return chatsResult.fold(
      (failure) async {
        return Left(NetworkFailure());
      },
      (result) async {
        chatBloc.add(SetSuggestionsResponseEvent(suggestionsResponse: result));
        return Right(null);
      },
    );
  }
}
