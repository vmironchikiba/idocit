// import 'package:live_footprint/common/models/app_settings_data.dart';
// import 'package:live_footprint/common/models/service/shared_preferences_datasource.dart';
// import 'package:live_footprint/common/providers/theme_provider.dart';
// import 'package:live_footprint/common/services/logger.dart';

import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/services/logger.dart';

class TtsPreferencesStorage extends AbstractSharedPreferencesDatasource {
  static String isEnabled = 'is_enabled';
  static String volume = 'volume';
  static String pitch = 'pitch';
  static String rate = 'rate';
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

  Future<double> readVolume() async {
    final volume = await TtsPreferencesStorage().read(TtsPreferencesStorage.volume);
    return volume;
  }

  Future<void> writeVolume(double volume) async {
    await TtsPreferencesStorage().write(TtsPreferencesStorage.volume, volume);
  }

  Future<double> readPitch() async {
    final pitch = await TtsPreferencesStorage().read(TtsPreferencesStorage.pitch);
    return pitch;
  }

  Future<void> writePitch(double pitch) async {
    await TtsPreferencesStorage().write(TtsPreferencesStorage.pitch, pitch);
  }

  Future<double> readRate() async {
    final rate = await TtsPreferencesStorage().read(TtsPreferencesStorage.rate);
    return rate;
  }

  Future<void> writeRate(double rate) async {
    await TtsPreferencesStorage().write(TtsPreferencesStorage.rate, rate);
  }
}
