part of 'core_bloc.dart';

class CoreState {
  final InAppToastData? inAppToastData;
  final bool screenlockIsEnabled;
  const CoreState({required this.inAppToastData, required this.screenlockIsEnabled});
  factory CoreState.initial() {
    return const CoreState(inAppToastData: null, screenlockIsEnabled: false);
  }

  CoreState updateInfoMessage({InAppToastData? infoMessage, bool? screenLock}) {
    return CoreState(inAppToastData: infoMessage, screenlockIsEnabled: screenLock ?? this.screenlockIsEnabled);
  }
}
