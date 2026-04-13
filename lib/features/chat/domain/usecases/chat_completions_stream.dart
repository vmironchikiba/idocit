import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/chat/domain/datasources/open_ai_stream_api.dart';
import 'package:idocit/features/chat/domain/models/query_response.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/injection_container.dart';

class ChatStartCompletionsStream implements UseCase<Either<Failure, void>, CompletionRequest> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final TtsService ttsService;
  var _buffer = '';
  var previewBuffer = '';
  var chatId = '';
  String get remainingBuffer => _buffer;
  // final List<String> preMessageArray = [];
  // String? traceId;
  // QueryResponse? queryResponse;

  ChatStartCompletionsStream({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.ttsService,
  });

  @override
  Future<Either<Failure, void>> call(CompletionRequest request) async {
    LoggerService.logDebug('ChatStartCompletionsStream -> call()');
    chatBloc.add(SetIsInProcess(isInProcess: true));

    if (!await networkListenerService.checkNetworkConnection(() => call(request))) {
      return const Left(NetworkFailure());
    }
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    chatId = '';
    chatBloc.add(SetChatTitle(chatTitle: request.content));
    OpenAIStreamApi(basePath: StringsConstants.basePath)
        .streamChatCompletions(request.toChatCompletionRequest(), token.accessToken)
        .listen(
          (chunk) {
            final currentChatId = chunk.id;
            if (currentChatId != null) {
              chatId = currentChatId;
              chatBloc.add(SetChatId(chatId: currentChatId));
            }
            if (chunk.choices.isEmpty) return;
            final choice = chunk.choices.first;
            final delta = Delta.fromJson(choice.delta);
            final content = delta.content;
            final toolCalls = delta.toolCalls ?? [];

            if (locator<TtsBloc>().state.isEnabled && content != null) {
              final sentences = addChunk(content);
              for (final sentence in sentences) {
                LoggerService.logDebug('🎤 Озвучиваем: "$sentence"');
                ttsService.speak(sentence).then((value) {
                  LoggerService.logDebug("Озвучиваем value: $value");
                  LoggerService.logDebug("Озвучиваем буфер: $_buffer");
                });
                // await tts.speak(sentence);
              }
              previewBuffer += content;
              // _buffer += content.replaceAll('\n', ' ');
            }

            final toolCall = toolCalls.isNotEmpty ? ToolCall.fromJson(toolCalls.first) : null;
            final arguments = toolCall?.function?.arguments;
            final updates = arguments?.updatesPayload;
            if (choice.finishReason == 'tool_calls') {
              if (arguments?.type == 'system.token') {
                final message = arguments?.message ?? '';
                if (message.isNotEmpty) {
                  final preMessageArray = chatBloc.state.preMessageArray;
                  preMessageArray.add(message);
                  chatBloc.add(SetPreMessageArray(preMessageArray: preMessageArray));
                }
              }
            }
            if (updates != null) {
              final system = updates.generation?.generationResult?.system;

              if (system != null) {
                chatBloc.add(SetGenerationResultSystem(generationResultSystem: system));
              }
              if (toolCall?.id == 'generation.node_update') {
                if (updates.generation?.knowledge != null) {
                  chatBloc.add(SetQueryResponse(queryResponse: updates.generation?.knowledge));
                }
                chatBloc.add(SetTraceId(traceId: arguments?.traceId));
              }
            }
            chatBloc.add(SetChunkEvent(chunk: chunk));
          },
          onError: (err) {
            chatBloc.add(SetIsInProcess(isInProcess: false));
            return Left(CommonFailure(message: err.toString(), type: CommonErrorType.badResponseData));
          },
          onDone: () {
            if (_buffer.isNotEmpty && locator<TtsBloc>().state.isEnabled) {
              final sentences = addChunk('', withEnd: true);
              for (final sentence in sentences) {
                LoggerService.logDebug('🎤 Озвучиваем: "$sentence"');
                ttsService.speak(sentence).then((value) {
                  LoggerService.logDebug("Озвучиваем value end: $value");
                  LoggerService.logDebug("Озвучиваем буфер end: $_buffer");
                });
                // await tts.speak(sentence);
              }
            }
            chatBloc.add(SetIsInProcess(isInProcess: false));
            chatBloc.add(SetChatId(chatId: chatId));
            if (request.onDone != null) {
              request.onDone!(chatId);
            }
          },
        );
    chatBloc.add(AddCompletionRequest(completionRequest: request));
    return Right(null);
  }

  List<String> addChunk(String chunk, {bool withEnd = false}) {
    // 1. Заменяем переносы строк на пробелы (как в React)
    _buffer += chunk.replaceAll('\n', ' ');

    final List<String> completedSentences = [];

    // 2. Ищем границы предложений вручную
    int lastCutPosition = 0;

    for (int i = 0; i < _buffer.length; i++) {
      final char = _buffer[i];

      // Проверяем, является ли символ концом предложения
      if (char == '.' || char == '!' || char == '?') {
        // Смотрим, что после знака
        if (i + 1 < _buffer.length) {
          final nextChar = _buffer[i + 1];
          // Если после знака пробел - это граница предложения
          if (nextChar == ' ') {
            // Забираем предложение ВКЛЮЧАЯ знак пунктуации
            final sentence = _buffer.substring(lastCutPosition, i + 1);
            completedSentences.add(sentence);
            lastCutPosition = i + 2; // Пропускаем знак + пробел
            i++; // Дополнительный шаг, чтобы не обрабатывать пробел
          }
        } else {
          if (withEnd) {
            final sentence = _buffer.substring(lastCutPosition, _buffer.length - 1);
            completedSentences.add(sentence);
            LoggerService.logDebug(sentence);
          }
          // Знак в конце строки - возможно, ещё не завершено
          // Не добавляем в completed, оставляем в буфере
          break;
        }
      }
    }

    // 3. Оставляем незаконченную часть в буфере (как в React)
    if (lastCutPosition < _buffer.length) {
      _buffer = _buffer.substring(lastCutPosition);
    } else {
      _buffer = '';
    }

    return completedSentences;
  }

  void reset() {
    _buffer = '';
  }
}

class TTSSentenceSplitter {
  String _buffer = '';

  /// Добавляет новый чанк и возвращает список законченных предложений
  List<String> addChunk(String chunk) {
    // 1. Заменяем переносы строк на пробелы (как в React)
    _buffer += chunk.replaceAll('\n', ' ');

    final List<String> completedSentences = [];

    // 2. Ищем границы предложений вручную
    int lastCutPosition = 0;

    for (int i = 0; i < _buffer.length; i++) {
      final char = _buffer[i];

      // Проверяем, является ли символ концом предложения
      if (char == '.' || char == '!' || char == '?') {
        // Смотрим, что после знака
        if (i + 1 < _buffer.length) {
          final nextChar = _buffer[i + 1];
          // Если после знака пробел - это граница предложения
          if (nextChar == ' ') {
            // Забираем предложение ВКЛЮЧАЯ знак пунктуации
            final sentence = _buffer.substring(lastCutPosition, i + 1);
            completedSentences.add(sentence);
            lastCutPosition = i + 2; // Пропускаем знак + пробел
            i++; // Дополнительный шаг, чтобы не обрабатывать пробел
          }
        } else {
          // Знак в конце строки - возможно, ещё не завершено
          // Не добавляем в completed, оставляем в буфере
          break;
        }
      }
    }

    // 3. Оставляем незаконченную часть в буфере (как в React)
    if (lastCutPosition < _buffer.length) {
      _buffer = _buffer.substring(lastCutPosition);
    } else {
      _buffer = '';
    }

    return completedSentences;
  }

  /// Сбрасывает буфер (при ошибке или завершении потока)
  void reset() {
    _buffer = '';
  }

  /// Возвращает текущий буфер (для отладки)
  String get remainingBuffer => _buffer;
}
