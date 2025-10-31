part of 'core_bloc.dart';

abstract class CoreBlocEvent {
  const CoreBlocEvent([List props = const []]) : super();
}

class UpdateInAppToastEvent extends CoreBlocEvent {
  final InAppToastData? inAppToastData;

  UpdateInAppToastEvent({required this.inAppToastData}) : super([inAppToastData]);
}
