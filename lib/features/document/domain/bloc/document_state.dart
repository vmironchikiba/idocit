part of 'document_bloc.dart';

class DocumentState {
  final DateTime selectedDate;
  final bool isInProcess;
  final DocumentResponse? documentResponse;

  const DocumentState({required this.selectedDate, required this.isInProcess, required this.documentResponse});

  factory DocumentState.initial() {
    return DocumentState(selectedDate: DateTime.now().toInit(), isInProcess: false, documentResponse: null);
  }

  DocumentState update({DateTime? selectedDate, bool? isInProcess, DocumentResponse? documentResponse}) {
    return DocumentState(
      selectedDate: selectedDate ?? this.selectedDate,
      isInProcess: isInProcess ?? this.isInProcess,
      documentResponse: documentResponse ?? this.documentResponse,
    );
  }
}
