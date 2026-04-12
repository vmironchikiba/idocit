import 'package:idocit/common/models/service/secure_datasource.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/tts/domain/models/tts_data.dart';

class TtsSecureStorage extends AbstractSecureDatasource {
  TtsSecureStorage() : super(id: 'tts');

  Future<TtsData?> readTtsData() async {
    LoggerService.logDebug('TtsSecureStorage -> readTtsData()');
    final enaled = await TtsSecureStorage().read('tts.is_enabled');

    if (enaled != null) {
      final isEnabled = bool.tryParse(enaled);
      if (isEnabled != null) {
        return TtsData(isEnabled: isEnabled);
      }
    }
    return null;
  }

  Future<void> writeTtsData(TtsData data) async {
    LoggerService.logDebug('TtsSecureStorage -> writeTtsData()');
    await TtsSecureStorage().write('tts.is_enabled', data.isEnabled.toString());
  }

  Future<void> deleteTtsData() async {
    LoggerService.logDebug('TtsSecureStorage -> deleteTtsData()');
    await TtsSecureStorage().delete('tts.is_enabled');
  }
}
