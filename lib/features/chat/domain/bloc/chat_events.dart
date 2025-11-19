part of 'chat_bloc.dart';

abstract class ChatBlocEvent {
  const ChatBlocEvent([List props = const []]) : super();
}

class SetSelectedDateEvent extends ChatBlocEvent {
  final DateTime date;

  SetSelectedDateEvent({required this.date}) : super([date]);
}

class SetSuggestionsResponseEvent extends ChatBlocEvent {
  SuggestionsResponse? suggestionsResponse;

  SetSuggestionsResponseEvent({required this.suggestionsResponse}) : super([suggestionsResponse]);
}

class SetQueryEvent extends ChatBlocEvent {
  String? query;

  SetQueryEvent({required this.query}) : super([query]);
}

class SetChunkEvent extends ChatBlocEvent {
  ChatCompletionChunk? chunk;

  SetChunkEvent({required this.chunk}) : super([chunk]);
}

class SignOutIdocItEvent extends ChatBlocEvent {
  SignOutIdocItEvent() : super();
}
