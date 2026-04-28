// ignore_for_file: constant_identifier_names

part of 'idocit_bloc.dart';

class IdocItState {
  static const int LIMIT = 500;
  static const int OFFSET = 0;
  final DateTime selectedDate;
  final List<ChatSummary> chats;
  final int limit;
  final int offset;
  final bool canGoForward;
  final bool canGoBack;
  const IdocItState({
    required this.selectedDate,
    required this.chats,
    required this.limit,
    required this.offset,
    required this.canGoForward,
    required this.canGoBack,
  });

  factory IdocItState.initial() {
    return IdocItState(
      selectedDate: DateTime.now().toInit(),
      chats: [],
      limit: LIMIT,
      offset: 0,
      canGoForward: true,
      canGoBack: false,
    );
  }

  IdocItState update({
    DateTime? selectedDate,
    List<ChatSummary>? chats,
    int? limit,
    int? offset,
    bool? canGoForward,
    bool? canGoBack,
  }) {
    return IdocItState(
      selectedDate: selectedDate ?? this.selectedDate,
      chats: chats ?? this.chats,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      canGoForward: canGoForward ?? this.canGoForward,
      canGoBack: canGoBack ?? this.canGoBack,
    );
  }
}
