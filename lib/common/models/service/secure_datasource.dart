import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/injection_container.dart';
import 'package:flutter/services.dart';

class AbstractSecureDatasource {
  final String id;
  static const _storage = FlutterSecureStorage();

  const AbstractSecureDatasource({required this.id});

  // Проверка на ошибку расшифровки (общий метод)
  static bool _isDecryptionError(PlatformException e) {
    return e.message?.contains('BadPaddingException') == true || e.message?.contains('BAD_DECRYPT') == true;
  }

  static Future<void> deleteStorage() async {
    try {
      await _storage.deleteAll();
    } on PlatformException catch (e) {
      if (_isDecryptionError(e)) {
        LoggerService.logDebug('Ошибка при очистке хранилища, но продолжаем');
        return;
      }
      rethrow;
    }
  }

  // READ - самая критичная операция
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: _getStorageID(key));
    } on PlatformException catch (e) {
      if (_isDecryptionError(e)) {
        LoggerService.logDebug('Поврежденные данные для ключа: $key, удаляем...');
        await _storage.delete(key: key); // Рекурсивно вызываем delete
        return null;
      }
      rethrow;
    }
  }

  // WRITE - тоже оборачиваем
  Future<void> write(String key, String? value) async {
    try {
      await _storage.write(key: _getStorageID(key), value: value);
    } on PlatformException catch (e) {
      if (_isDecryptionError(e)) {
        // Пытаемся сначала удалить старые поврежденные данные
        await _storage.delete(key: _getStorageID(key));
        // Повторяем запись
        await _storage.write(key: _getStorageID(key), value: value);
        return;
      }
      rethrow;
    }
  }

  // DELETE - минимальный риск, но для единообразия
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: _getStorageID(key));
    } on PlatformException catch (e) {
      if (_isDecryptionError(e)) {
        // Если не можем удалить из-за ошибки шифрования,
        // скорее всего данных уже нет или они недоступны
        LoggerService.logDebug('Не удалось удалить ключ ${_getStorageID(key)} из-за ошибки шифрования, игнорируем');
        return; // Считаем, что удаление выполнено успешно
      }
      rethrow;
    }
  }

  // Остальные методы тоже можно обернуть по аналогии
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: _getStorageID(key));
    } on PlatformException catch (e) {
      if (_isDecryptionError(e)) {
        return false;
      }
      rethrow;
    }
  }

  String _getStorageID(String key) {
    return '$id.${locator<DeviceService>().currentBuildMode().toBuildSuffix()}$key';
  }
}
