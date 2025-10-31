part of 'core_bloc.dart';

class CoreState {
  final InAppToastData? inAppToastData;
  const CoreState({required this.inAppToastData});
  factory CoreState.initial() {
    return const CoreState(inAppToastData: null);
  }

  CoreState updateInfoMessage({InAppToastData? infoMessage}) {
    return CoreState(inAppToastData: infoMessage);
  }
}
