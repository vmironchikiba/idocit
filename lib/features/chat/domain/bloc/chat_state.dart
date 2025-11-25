part of 'chat_bloc.dart';

class ChatState {
  final DateTime selectedDate;
  final bool isInProcess;
  final SuggestionsResponse? suggestionsResponse;
  final String? query;
  final ChatCompletionChunk? chunk;
  final String? generationResultSystem;
  final QueryResponse? queryResponse;
  final String? traceId;
  final List<String> preMessageArray;
  const ChatState({
    required this.selectedDate,
    required this.isInProcess,
    required this.suggestionsResponse,
    required this.query,
    this.chunk,
    this.generationResultSystem,
    this.queryResponse,
    this.traceId,
    required this.preMessageArray,
  });

  factory ChatState.initial() {
    return ChatState(
      selectedDate: DateTime.now().toInit(),
      isInProcess: false,
      suggestionsResponse: null,
      query: null,
      chunk: null,
      generationResultSystem: null,
      queryResponse: null,
      traceId: null,
      preMessageArray: [],
    );
  }

  ChatState update({
    DateTime? selectedDate,
    bool? isInProcess,
    SuggestionsResponse? suggestionsResponse,
    String? query,
    ChatCompletionChunk? chunk,
    String? generationResultSystem,
    QueryResponse? queryResponse,
    String? traceId,
    List<String>? preMessageArray,
  }) {
    return ChatState(
      selectedDate: selectedDate ?? this.selectedDate,
      isInProcess: isInProcess ?? this.isInProcess,
      suggestionsResponse: suggestionsResponse ?? this.suggestionsResponse,
      query: query ?? this.query,
      chunk: chunk ?? this.chunk,
      generationResultSystem: generationResultSystem ?? this.generationResultSystem,
      queryResponse: queryResponse ?? this.queryResponse,
      traceId: traceId ?? this.traceId,
      preMessageArray: preMessageArray ?? this.preMessageArray,
    );
  }

  ChatState deleteSuggestions() {
    return ChatState(
      selectedDate: selectedDate,
      isInProcess: isInProcess,
      suggestionsResponse: null,
      query: query,
      chunk: chunk,
      generationResultSystem: generationResultSystem,
      queryResponse: queryResponse,
      traceId: traceId,
      preMessageArray: preMessageArray,
    );
  }
}
