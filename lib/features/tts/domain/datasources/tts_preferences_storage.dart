// import 'package:live_footprint/common/models/app_settings_data.dart';
// import 'package:live_footprint/common/models/service/shared_preferences_datasource.dart';
// import 'package:live_footprint/common/providers/theme_provider.dart';
// import 'package:live_footprint/common/services/logger.dart';

import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/services/logger.dart';

class TtsPreferencesStorage extends AbstractSharedPreferencesDatasource {
  static String isEnabled = 'is_enabled';
  static String isRanBefore = 'is_ran_before';
  TtsPreferencesStorage() : super(id: 'tts');

  Future<bool> readAppRunConfigurationValue() async {
    LoggerService.logDebug('CorePreferencesStorage -> readAppRunConfigurationValue()');
    return (await TtsPreferencesStorage().read(TtsPreferencesStorage.isRanBefore)) ?? false;
  }

  Future<void> writeAppRunConfigurationValue(bool isRanBefore) async {
    LoggerService.logDebug('CorePreferencesStorage -> writeAppRunConfigurationValue()');
    await TtsPreferencesStorage().write(TtsPreferencesStorage.isRanBefore, isRanBefore);
  }

  Future<bool> readIsEnabled() async {
    final isEnabled = await TtsPreferencesStorage().read(TtsPreferencesStorage.isEnabled);
    return isEnabled;
  }

  Future<void> writeIsEnabled(bool isEnabled) async {
    LoggerService.logDebug('CorePreferencesStorage -> writeCoreSettings()');
    await TtsPreferencesStorage().write(TtsPreferencesStorage.isEnabled, isEnabled);
  }
}
