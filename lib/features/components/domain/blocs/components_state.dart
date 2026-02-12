part of 'components_bloc.dart';

class ComponentsState {
  final DateTime updated;
  final ComponentConfig? componentConfig;
  const ComponentsState({required this.updated, required this.componentConfig});

  factory ComponentsState.initial() {
    return ComponentsState(updated: DateTime.now().toInit(), componentConfig: null);
  }

  ComponentsState update({DateTime? updated, ComponentConfig? componentConfig}) {
    return ComponentsState(updated: updated ?? this.updated, componentConfig: componentConfig ?? this.componentConfig);
  }
}
