part of 'document_bloc.dart';

abstract class DocumentBlocEvent {
  const DocumentBlocEvent([List props = const []]) : super();
}

class SetSelectedDateEvent extends DocumentBlocEvent {
  final DateTime date;
  SetSelectedDateEvent({required this.date}) : super([date]);
}

class SetIsInProcess extends DocumentBlocEvent {
  final bool isInProcess;
  SetIsInProcess({required this.isInProcess}) : super([isInProcess]);
}

class SetDocumentResponseEvent extends DocumentBlocEvent {
  DocumentResponse? documentResponse;
  SetDocumentResponseEvent({required this.documentResponse}) : super([documentResponse]);
}

class SignOutIdocItEvent extends DocumentBlocEvent {
  SignOutIdocItEvent() : super();
}
