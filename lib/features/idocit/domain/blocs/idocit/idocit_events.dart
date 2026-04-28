part of 'idocit_bloc.dart';

abstract class IdocItBlocEvent {
  const IdocItBlocEvent([List props = const []]) : super();
}

class SetSelectedDateEvent extends IdocItBlocEvent {
  final DateTime date;

  SetSelectedDateEvent({required this.date}) : super([date]);
}

class SetChatsEvent extends IdocItBlocEvent {
  final List<ChatSummary> chats;
  final int offset;
  final int limit;
  final bool canGoBack;
  final bool canGoForward;
  SetChatsEvent({
    required this.chats,
    required this.offset,
    required this.limit,
    required this.canGoBack,
    required this.canGoForward,
  }) : super([chats, offset, limit, canGoBack, canGoForward]);
}

class SignOutIdocItEvent extends IdocItBlocEvent {
  SignOutIdocItEvent() : super();
}

class IdocItResetEvent extends IdocItBlocEvent {
  IdocItResetEvent() : super();
}
