import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/datasources/core_preferences_storage.dart';
import 'package:idocit/common/models/app_settings_data.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/style.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CoreUpdateScreenlockIsEnabled implements UseCase<void, bool> {
  final CoreBloc coreBloc;
  final CorePreferencesStorage storage;

  const CoreUpdateScreenlockIsEnabled({required this.coreBloc, required this.storage});

  @override
  Future<void> call(bool screenlockIsEnabled) async {
    LoggerService.logDebug('CoreUpdateFailure -> call()');
    await WakelockPlus.toggle(enable: screenlockIsEnabled);
    storage.writeCoreSettings(AppSettingsData(screenlockIsEnabled: screenlockIsEnabled));

    coreBloc.add(UpdateScreenLock(screenlockIsEnabled: screenlockIsEnabled));
    await Future.delayed(StyleConstants.defaultDelayDuration);
  }
}
