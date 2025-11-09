part of 'chat_bloc.dart';

class ChatState {
  final DateTime selectedDate;
  final SuggestionsResponse? suggestionsResponse;
  final String? query;
  const ChatState({required this.selectedDate, required this.suggestionsResponse, required this.query});

  factory ChatState.initial() {
    return ChatState(selectedDate: DateTime.now().toInit(), suggestionsResponse: null, query: null);
  }

  ChatState update({DateTime? selectedDate, SuggestionsResponse? suggestionsResponse, String? query}) {
    return ChatState(
      selectedDate: selectedDate ?? this.selectedDate,
      suggestionsResponse: suggestionsResponse ?? this.suggestionsResponse,
      query: query ?? this.query,
    );
  }
}
