import 'package:idocit/common/models/service/secure_datasource.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/models/tts_data.dart';

class TtsSecureStorage extends AbstractSecureDatasource {
  TtsSecureStorage() : super(id: 'tts');

  Future<TtsData?> readTtsData() async {
    LoggerService.logDebug('TtsSecureStorage -> readTtsData()');
    try {
      final enabled = await TtsSecureStorage().read('tts.is_enabled');

      if (enabled != null) {
        final isEnabled = bool.tryParse(enabled);
        if (isEnabled != null) {
          return TtsData(isEnabled: isEnabled);
        }
      }
    } catch (e) {
      LoggerService.logDebug('TtsSecureStorage->readTokensData error: ${e.toString()}');
      return null;
    }
    return null;
  }

  Future<void> writeTtsData(TtsData data) async {
    LoggerService.logDebug('TtsSecureStorage -> writeTtsData()');
    try {
      await TtsSecureStorage().write('tts.is_enabled', data.isEnabled.toString());
    } catch (e) {
      LoggerService.logDebug('TtsSecureStorage->writeTtsData error: ${e.toString()}');
      return;
    }
  }

  Future<void> deleteTtsData() async {
    LoggerService.logDebug('TtsSecureStorage -> deleteTtsData()');
    try {
      await TtsSecureStorage().delete('tts.is_enabled');
    } catch (e) {
      LoggerService.logDebug('TtsSecureStorage->deleteTtsData error: ${e.toString()}');
      return;
    }
  }
}
