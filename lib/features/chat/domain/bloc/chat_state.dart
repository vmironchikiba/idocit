part of 'chat_bloc.dart';

class ChatState {
  final DateTime selectedDate;
  final bool isInProcess;
  final SuggestionsResponse? suggestionsResponse;
  final String? query;
  final ChatCompletionChunk? chunk;
  final List<CompletionRequest> completionRequests;
  final String? generationResultSystem;
  final QueryResponse? queryResponse;
  final String? traceId;
  final String? chatId;
  final String? chatTitle;
  final List<String> preMessageArray;
  final List<ChatHistoryMessage> chatHistoryMessages;
  const ChatState({
    required this.selectedDate,
    required this.isInProcess,
    required this.suggestionsResponse,
    required this.query,
    this.chunk,
    this.completionRequests = const [],
    this.generationResultSystem,
    this.queryResponse,
    this.traceId,
    this.chatId,
    this.chatTitle,
    required this.preMessageArray,
    this.chatHistoryMessages = const [],
  });

  factory ChatState.initial() {
    return ChatState(
      selectedDate: DateTime.now().toInit(),
      isInProcess: false,
      suggestionsResponse: null,
      query: null,
      chunk: null,
      completionRequests: [],
      generationResultSystem: null,
      queryResponse: null,
      traceId: null,
      chatId: null,
      chatTitle: null,
      preMessageArray: [],
      chatHistoryMessages: [],
    );
  }

  ChatState update({
    DateTime? selectedDate,
    bool? isInProcess,
    SuggestionsResponse? suggestionsResponse,
    String? query,
    ChatCompletionChunk? chunk,
    CompletionRequest? completionRequest,
    String? generationResultSystem,
    QueryResponse? queryResponse,
    String? traceId,
    String? chatId,
    String? chatTitle,
    List<String>? preMessageArray,
    List<ChatHistoryMessage>? chatHistoryMessages,
  }) {
    return ChatState(
      selectedDate: selectedDate ?? this.selectedDate,
      isInProcess: isInProcess ?? this.isInProcess,
      suggestionsResponse: suggestionsResponse ?? this.suggestionsResponse,
      query: query ?? this.query,
      chunk: chunk ?? this.chunk,
      completionRequests: completionRequest != null ? [...completionRequests, completionRequest] : completionRequests,
      generationResultSystem: generationResultSystem ?? this.generationResultSystem,
      queryResponse: queryResponse ?? this.queryResponse,
      traceId: traceId ?? this.traceId,
      chatId: chatId ?? this.chatId,
      chatTitle: chatTitle ?? this.chatTitle,
      preMessageArray: preMessageArray ?? this.preMessageArray,
      chatHistoryMessages: chatHistoryMessages ?? this.chatHistoryMessages,
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
      chatId: chatId,
      chatTitle: chatTitle,
      preMessageArray: preMessageArray,
      chatHistoryMessages: chatHistoryMessages,
    );
  }

  ChatState deleteCompletionRequest() {
    return ChatState(
      selectedDate: selectedDate,
      isInProcess: isInProcess,
      suggestionsResponse: suggestionsResponse,
      query: query,
      chunk: chunk,
      completionRequests: [],
      generationResultSystem: generationResultSystem,
      queryResponse: queryResponse,
      traceId: traceId,
      chatId: chatId,
      chatTitle: chatTitle,
      preMessageArray: preMessageArray,
      chatHistoryMessages: chatHistoryMessages,
    );
  }

  ChatState deleteGenerationResultSystem() {
    return ChatState(
      selectedDate: selectedDate,
      isInProcess: isInProcess,
      suggestionsResponse: suggestionsResponse,
      query: query,
      chunk: chunk,
      completionRequests: completionRequests,
      generationResultSystem: null,
      queryResponse: queryResponse,
      traceId: traceId,
      chatId: chatId,
      chatTitle: chatTitle,
      preMessageArray: preMessageArray,
      chatHistoryMessages: chatHistoryMessages,
    );
  }

  ChatState deletePreMessageArray() {
    return ChatState(
      selectedDate: selectedDate,
      isInProcess: isInProcess,
      suggestionsResponse: suggestionsResponse,
      query: query,
      chunk: chunk,
      completionRequests: completionRequests,
      generationResultSystem: generationResultSystem,
      queryResponse: queryResponse,
      traceId: traceId,
      chatId: chatId,
      chatTitle: chatTitle,
      preMessageArray: [],
      chatHistoryMessages: chatHistoryMessages,
    );
  }

  ChatState deleteQueryResponse() {
    return ChatState(
      selectedDate: selectedDate,
      isInProcess: isInProcess,
      suggestionsResponse: suggestionsResponse,
      query: query,
      chunk: chunk,
      completionRequests: completionRequests,
      generationResultSystem: generationResultSystem,
      queryResponse: null,
      traceId: traceId,
      chatId: chatId,
      chatTitle: chatTitle,
      preMessageArray: preMessageArray,
      chatHistoryMessages: chatHistoryMessages,
    );
  }

  ChatState deleteRequestedData() {
    return deleteCompletionRequest().deleteGenerationResultSystem().deletePreMessageArray().deleteQueryResponse();
  }
}
//