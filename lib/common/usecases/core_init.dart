import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/datasources/core_preferences_storage.dart';
import 'package:idocit/common/models/service/secure_datasource.dart';
import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/providers/charles_provider.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CoreInit implements UseCase<void, NoParams> {
  final CoreBloc coreBloc;
  final CorePreferencesStorage corePreferencesStorage;
  final ThemeProvider themeProvider;
  final CharlesProvider charlesProvider;

  const CoreInit({
    required this.coreBloc,
    required this.corePreferencesStorage,
    required this.themeProvider,
    required this.charlesProvider,
  });

  @override
  Future<void> call(NoParams params) async {
    LoggerService.logDebug('CoreInit -> call()');
    final isRanBefore = await corePreferencesStorage.readAppRunConfigurationValue();
    if (!isRanBefore) {
      try {
        await AbstractSecureDatasource.deleteStorage();
        await AbstractSharedPreferencesDatasource.deletePreferences();
        await corePreferencesStorage.writeAppRunConfigurationValue(true);
      } catch (e) {
        LoggerService.logDebug('AuthSecureStorage->readTokensData error: ${e.toString()}');
      }
    }

    final settingsData = await corePreferencesStorage.readCoreSettings();
    themeProvider.update(type: settingsData.themeType);
    charlesProvider.update(isEnabled: settingsData.isCharlesProxyEnabled, proxyIP: settingsData.proxyIP);
    final screenlockIsEnabled = settingsData.screenlockIsEnabled ?? false;
    await WakelockPlus.toggle(enable: screenlockIsEnabled);
    coreBloc.add(UpdateScreenLock(screenlockIsEnabled: screenlockIsEnabled));
  }
}
