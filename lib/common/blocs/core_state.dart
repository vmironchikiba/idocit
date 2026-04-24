part of 'core_bloc.dart';

class CoreState {
  final InAppToastData? inAppToastData;
  final bool screenLock;
  const CoreState({required this.inAppToastData, required this.screenLock});
  factory CoreState.initial() {
    WakelockPlus.enabled.then((screenLock) {
      UpdateScreenLock(screenLock: screenLock);
    });
    return const CoreState(inAppToastData: null, screenLock: false);
  }

  CoreState updateInfoMessage({InAppToastData? infoMessage, bool? screenLock}) {
    return CoreState(inAppToastData: infoMessage, screenLock: screenLock ?? this.screenLock);
  }
}
