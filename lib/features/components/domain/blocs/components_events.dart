part of 'components_bloc.dart';

abstract class ComponentsBlocEvent {
  const ComponentsBlocEvent([List props = const []]) : super();
}

class SetUpdatedDateEvent extends ComponentsBlocEvent {
  final DateTime date;

  SetUpdatedDateEvent({required this.date}) : super([date]);
}

class SetComponentConfigEvent extends ComponentsBlocEvent {
  ComponentConfig componentConfig;

  SetComponentConfigEvent({required this.componentConfig}) : super([componentConfig]);
}

class ResetComponentConfigEvent extends ComponentsBlocEvent {
  ResetComponentConfigEvent() : super([]);
}
