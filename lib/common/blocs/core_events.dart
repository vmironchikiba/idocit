part of 'core_bloc.dart';

abstract class CoreBlocEvent {
  const CoreBlocEvent([List props = const []]) : super();
}

class UpdateInAppToastEvent extends CoreBlocEvent {
  final InAppToastData? inAppToastData;

  UpdateInAppToastEvent({required this.inAppToastData}) : super([inAppToastData]);
}

class UpdateScreenLock extends CoreBlocEvent {
  final bool screenlockIsEnabled;
  UpdateScreenLock({required this.screenlockIsEnabled}) : super([screenlockIsEnabled]);
}

class SignOutCoreEvent extends CoreBlocEvent {
  SignOutCoreEvent() : super();
}
