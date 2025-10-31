import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/injection_container.dart';

class AbstractSecureDatasource {
  final String id;
  static const _storage = FlutterSecureStorage();

  const AbstractSecureDatasource({required this.id});

  static Future<void> deleteStorage() async {
    await _storage.deleteAll();
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: _getStorageID(key));
  }

  Future<void> write(String key, String? value) async {
    await _storage.write(key: _getStorageID(key), value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: _getStorageID(key));
  }

  String _getStorageID(String key) {
    return '$id.${locator<DeviceService>().currentBuildMode().toBuildSuffix()}$key';
  }
}
