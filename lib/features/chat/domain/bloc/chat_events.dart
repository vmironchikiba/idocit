part of 'chat_bloc.dart';

abstract class ChatBlocEvent {
  const ChatBlocEvent([List props = const []]) : super();
}

class SetSelectedDateEvent extends ChatBlocEvent {
  final DateTime date;
  SetSelectedDateEvent({required this.date}) : super([date]);
}

class SetIsInProcess extends ChatBlocEvent {
  final bool isInProcess;
  SetIsInProcess({required this.isInProcess}) : super([isInProcess]);
}

class SetSuggestionsResponseEvent extends ChatBlocEvent {
  SuggestionsResponse? suggestionsResponse;

  SetSuggestionsResponseEvent({required this.suggestionsResponse}) : super([suggestionsResponse]);
}

class ResetSuggestionsEvent extends ChatBlocEvent {
  ResetSuggestionsEvent() : super([]);
}

class SetQueryEvent extends ChatBlocEvent {
  String? query;

  SetQueryEvent({required this.query}) : super([query]);
}

class SetChunkEvent extends ChatBlocEvent {
  ChatCompletionChunk? chunk;
  SetChunkEvent({required this.chunk}) : super([chunk]);
}

class SetGenerationResultSystem extends ChatBlocEvent {
  String? generationResultSystem;
  SetGenerationResultSystem({required this.generationResultSystem}) : super([generationResultSystem]);
}

class SetQueryResponse extends ChatBlocEvent {
  QueryResponse? queryResponse;
  SetQueryResponse({required this.queryResponse}) : super([queryResponse]);
}

class SetTraceId extends ChatBlocEvent {
  String? traceId;
  SetTraceId({required this.traceId}) : super([traceId]);
}

class SetPreMessageArray extends ChatBlocEvent {
  List<String> preMessageArray;
  SetPreMessageArray({required this.preMessageArray}) : super([preMessageArray]);
}

class AddCompletionRequest extends ChatBlocEvent {
  CompletionRequest completionRequest;
  AddCompletionRequest({required this.completionRequest}) : super([completionRequest]);
}

class SetChatHistoryMessages extends ChatBlocEvent {
  List<ChatHistoryMessage> chatHistoryMessages;
  SetChatHistoryMessages({required this.chatHistoryMessages}) : super([chatHistoryMessages]);
}

class SignOutIdocItEvent extends ChatBlocEvent {
  SignOutIdocItEvent() : super();
}

class ChatResettEvent extends ChatBlocEvent {
  ChatResettEvent() : super();
}
