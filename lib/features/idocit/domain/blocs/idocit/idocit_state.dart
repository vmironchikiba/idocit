part of 'idocit_bloc.dart';

class IdocItState {
  final DateTime selectedDate;
  final List<ChatSummary> chats;
  const IdocItState({required this.selectedDate, required this.chats});

  factory IdocItState.initial() {
    return IdocItState(selectedDate: DateTime.now().toInit(), chats: []);
  }

  IdocItState update({DateTime? selectedDate, List<ChatSummary>? chats}) {
    return IdocItState(selectedDate: selectedDate ?? this.selectedDate, chats: chats ?? this.chats);
  }
}
