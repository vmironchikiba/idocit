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

class ChatStartCompletionsStream implements UseCase<Either<Failure, void>, CompletionRequest> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  var buffer = '';
  var previewBuffer = '';
  // final List<String> preMessageArray = [];
  // String? traceId;
  // QueryResponse? queryResponse;

  ChatStartCompletionsStream({required this.networkListenerService, required this.chatBloc, required this.authBloc});

  @override
  Future<Either<Failure, void>> call(CompletionRequest request) async {
    LoggerService.logDebug('ChatStartCompletionsStream -> call()');
    chatBloc.add(SetIsInProcess(isInProcess: true));

    if (!await networkListenerService.checkNetworkConnection(() => call(request))) {
      return const Left(NetworkFailure());
    }
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    OpenAIStreamApi(basePath: StringsConstants.basePath)
        .streamChatCompletions(request.toChatCompletionRequest(), token.accessToken)
        .listen(
          (chunk) {
            if (chunk.choices.isEmpty) return;
            LoggerService.logDebug('EEEEEEEEEEEEEEEEEEEEE ${chunk.toString()}EEEEEEEE');
            final choice = chunk.choices[0];
            final delta = choice.delta;
            final toolCalls = delta['tool_calls'] as List<dynamic>? ?? [];
            final content = delta['content'] as String?;
            if (content != null) {
              buffer += content.replaceAll('\n', ' ');
              previewBuffer += content;
            }

            //
            if (toolCalls.isNotEmpty) {
              final finishReasonIsToolCalls = choice.finishReason == 'tool_calls';

              final Map toolCall = (toolCalls[0] as Map?) ?? {};
              final toolCallId = toolCall['id'] as String?;
              final Map function = (toolCall['function'] as Map?) ?? {};
              final Map arguments = (function['arguments'] as Map?) ?? {};
              final isReasonSystemToken = (arguments['type'] as String?) == 'system.token';
              if (finishReasonIsToolCalls) {
                if (isReasonSystemToken) {
                  final message = (arguments['message'] as String?) ?? '';
                  if (message.isNotEmpty) {
                    final preMessageArray = chatBloc.state.preMessageArray;
                    preMessageArray.add(message);
                    chatBloc.add(SetPreMessageArray(preMessageArray: preMessageArray));
                  }
                }
              }
              final data = arguments['data'] as List? ?? [];
              if (data.length > 1) {
                final first = data[0];
                if (first == 'updates') {
                  final Map second = (data[1] as Map?) ?? {};
                  final Map generation = (second['generation'] as Map?) ?? {};
                  if (toolCallId == 'generation.node_update') {
                    final queryResponse = QueryResponse.fromJson(generation['knowledge']);
                    chatBloc.add(SetQueryResponse(queryResponse: QueryResponse.fromJson(generation['knowledge'])));
                    // traceId = arguments['trace_id'];
                    chatBloc.add(SetTraceId(traceId: arguments['trace_id']));
                  }
                  final Map generationResult = (generation['generation_result'] as Map?) ?? {};
                  final system = generationResult['system'] as String?;
                  if (system != null) {
                    chatBloc.add(SetGenerationResultSystem(generationResultSystem: system));
                  }
                }
              }
            }

            //  final toolCallsId = toolCalls != null ? toolCalls!['tool_calls'] : '';

            chatBloc.add(SetChunkEvent(chunk: chunk));
          },
          onError: (err) {
            chatBloc.add(SetIsInProcess(isInProcess: false));
            return Left(CommonFailure(message: err.toString(), type: CommonErrorType.badResponseData));
          },
          onDone: () => chatBloc.add(SetIsInProcess(isInProcess: false)),
        );
    chatBloc.add(AddCompletionRequest(completionRequest: request));
    return Right(null);
  }
}
