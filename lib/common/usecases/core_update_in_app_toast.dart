import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/models/in_app_toast_data.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';

class CoreUpdateInAppToast implements UseCase<void, InAppToastData?> {
  final CoreBloc coreBloc;

  const CoreUpdateInAppToast({required this.coreBloc});

  @override
  Future<void> call(InAppToastData? data) async {
    if (data?.id == coreBloc.state.inAppToastData?.id) {
      return;
    }

    if (data?.type == InAppToastType.network) {
      return;
    }

    LoggerService.logDebug('CoreUpdateInAppToast -> call(id: ${data?.id}, key: ${data?.key})');
    if (data == null) {
      coreBloc.add(UpdateInAppToastEvent(inAppToastData: coreBloc.state.inAppToastData?.empty()));
    } else {
      coreBloc.add(UpdateInAppToastEvent(inAppToastData: data));
    }
  }
}
