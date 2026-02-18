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
            final choice = chunk.choices.first;
            final delta = Delta.fromJson(choice.delta);
            final content = delta.content;
            final toolCalls = delta.toolCalls ?? [];
            if (content != null) {
              buffer += content.replaceAll('\n', ' ');
              previewBuffer += content;
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
          onDone: () => chatBloc.add(SetIsInProcess(isInProcess: false)),
        );
    chatBloc.add(AddCompletionRequest(completionRequest: request));
    return Right(null);
  }
}
