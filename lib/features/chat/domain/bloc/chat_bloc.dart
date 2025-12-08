import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/date_time.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/chat/domain/models/query_response.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'chat_events.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatBlocEvent, ChatState> {
  ChatBloc(super.initialState) {
    on<SetSelectedDateEvent>((event, emit) => emit(state.update(selectedDate: event.date)));

    on<SetIsInProcess>((event, emit) => emit(state.update(isInProcess: event.isInProcess)));

    on<SetSuggestionsResponseEvent>((event, emit) {
      LoggerService.logDebug('ChatBloc SetSuggestionsResponseEvent ${event.suggestionsResponse.toString()}');
      emit(state.update(suggestionsResponse: event.suggestionsResponse));
    });

    on<ResetSuggestionsEvent>((event, emit) => emit(state.deleteSuggestions()));

    on<SetQueryResponse>((event, emit) {
      LoggerService.logDebug('ChatBloc SetQueryResponse ${event.queryResponse.toString()}');
      emit(state.update(queryResponse: event.queryResponse));
    });

    on<SetTraceId>((event, emit) {
      LoggerService.logDebug('ChatBloc SetTraceId ${event.traceId}');
      emit(state.update(traceId: event.traceId));
    });

    on<SetPreMessageArray>((event, emit) {
      LoggerService.logDebug('ChatBloc SetPreMessageArray ${event.preMessageArray}');
      emit(state.update(preMessageArray: event.preMessageArray));
    });
    //
    on<AddCompletionRequest>((event, emit) {
      LoggerService.logDebug('ChatBloc SetPreMessageArray ${event.completionRequest}');
      emit(state.update(completionRequest: event.completionRequest));
    });

    on<SetChatHistoryMessages>((event, emit) {
      LoggerService.logDebug('ChatBloc SetChatHistoryMessages ${event.chatHistoryMessages.length}');
      emit(state.update(chatHistoryMessages: event.chatHistoryMessages));
    });

    //SetChatHistoryMessages
    on<SetChunkEvent>((event, emit) {
      if (event.chunk != null) {
        final choice = event.chunk!.choices[0];
        final delta = choice.delta;
        final toolCalls = delta['tool_calls'] as List<dynamic>? ?? [];
        if (toolCalls.isNotEmpty) {
          final Map toolCall = (toolCalls[0] as Map?) ?? {};
          final Map function = (toolCall['function'] as Map?) ?? {};
          final Map arguments = (function['arguments'] as Map?) ?? {};
          final data = arguments['data'] as List? ?? [];
          if (data.length > 1) {
            final first = data[0];
            if (first == 'updates') {
              final Map second = (data[1] as Map?) ?? {};
              final Map generation = (second['generation'] as Map?) ?? {};
              final Map generationResult = (generation['generation_result'] as Map?) ?? {};
              final system = generationResult['system'] as String?;
              if (system != null) {
                LoggerService.logDebug('//////////////////////////////////////////');
                LoggerService.logDebug(system);
                LoggerService.logDebug('//////////////////////////////////////////');
              }
            }
          }
        }

        //  final toolCallsId = toolCalls != null ? toolCalls!['tool_calls'] : '';
      }

      emit(state.update(chunk: event.chunk));
    });

    on<SetGenerationResultSystem>((event, emit) {
      LoggerService.logDebug('ChatBloc SetGenerationResultSystem ${event.generationResultSystem}');
      emit(state.update(generationResultSystem: event.generationResultSystem));
    });

    on<SetQueryEvent>((event, emit) {
      emit(state.update(query: event.query));
    });

    on<SignOutIdocItEvent>((event, emit) {
      emit(ChatState.initial());
    });
  }

  @override
  void onEvent(ChatBlocEvent event) {
    super.onEvent(event);
    LoggerService.logDebug('IdocItBloc -> onEvent(): ${event.runtimeType}');
  }
}
