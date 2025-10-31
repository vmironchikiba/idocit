import 'package:idocit/common/models/app_settings_data.dart';
import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/logger.dart';

class CorePreferencesStorage extends AbstractSharedPreferencesDatasource {
  CorePreferencesStorage() : super(id: 'core');

  Future<bool> readAppRunConfigurationValue() async {
    LoggerService.logDebug('CorePreferencesStorage -> readAppRunConfigurationValue()');
    return (await CorePreferencesStorage().read('is_ran_before')) ?? false;
  }

  Future<void> writeAppRunConfigurationValue(bool isRanBefore) async {
    LoggerService.logDebug('CorePreferencesStorage -> writeAppRunConfigurationValue()');
    await CorePreferencesStorage().write('is_ran_before', isRanBefore);
  }

  Future<AppSettingsData> readCoreSettings() async {
    LoggerService.logDebug('CorePreferencesStorage -> readCoreSettings()');
    final themeTypeIndex = await CorePreferencesStorage().read('selected_theme_type');
    final isCharlesProxyEnabled = await CorePreferencesStorage().read('is_charles_proxy_enabled');
    final proxyIP = await CorePreferencesStorage().read('proxy_ip');

    return AppSettingsData(
      themeType: themeTypeIndex is int ? ThemeStyleType.values[themeTypeIndex] : null,
      isCharlesProxyEnabled: isCharlesProxyEnabled,
      proxyIP: proxyIP,
    );
  }

  Future<void> writeCoreSettings(AppSettingsData settingsData) async {
    LoggerService.logDebug('CorePreferencesStorage -> writeCoreSettings()');
    if (settingsData.themeType != null) {
      await CorePreferencesStorage().write('selected_theme_type', settingsData.themeType?.index);
    }

    if (settingsData.isCharlesProxyEnabled != null) {
      await CorePreferencesStorage().write('is_charles_proxy_enabled', settingsData.isCharlesProxyEnabled);
    }

    if (settingsData.proxyIP != null) {
      await CorePreferencesStorage().write('proxy_ip', settingsData.proxyIP);
    }
  }
}
