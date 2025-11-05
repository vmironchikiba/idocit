part of 'idocit_bloc.dart';

class IdocItState {
  final DateTime selectedDate;
  const IdocItState({required this.selectedDate});

  factory IdocItState.initial() {
    return IdocItState(selectedDate: DateTime.now().toInit());
  }

  IdocItState update({DateTime? selectedDate}) {
    return IdocItState(selectedDate: selectedDate ?? this.selectedDate);
  }
}
