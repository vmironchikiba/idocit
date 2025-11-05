part of 'idocit_bloc.dart';

abstract class IdocItBlocEvent {
  const IdocItBlocEvent([List props = const []]) : super();
}

class SetSelectedDateEvent extends IdocItBlocEvent {
  final DateTime date;

  SetSelectedDateEvent({required this.date}) : super([date]);
}

class SignOutIdocItEvent extends IdocItBlocEvent {
  SignOutIdocItEvent() : super();
}
