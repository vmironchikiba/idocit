import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum BuildMode { dev, prod }

extension BuildModeExtension on BuildMode {
  String toStringLabel() {
    switch (this) {
      case BuildMode.prod:
        return 'Production';

      default:
        return 'Dev';
    }
  }

  String toBuildSuffix() {
    switch (this) {
      case BuildMode.prod:
        return 'prod';

      default:
        return 'dev';
    }
  }
}

class DeviceService {
  late final PackageInfo _packageInfo;
  late final bool _isPhysicalDevice;

  // ignore: unused_field
  static const _devPackageName = 'TODO';
  static const _prodPackageName = 'TODO';

  static const _devLinkHost = 'TODO';
  static const _prodLinkHost = 'TODO';
  static const _devIsi = 'TODO';
  static const _prodIsi = 'TODO';

  PackageInfo get packageInfo => _packageInfo;
  bool get isRunOnPhysicalDevice => _isPhysicalDevice;

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _isPhysicalDevice = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _isPhysicalDevice = iosInfo.isPhysicalDevice;
    } else {
      _isPhysicalDevice = true;
    }
  }

  Future<String> getPackageName() async => (await PackageInfo.fromPlatform()).packageName;
  Future<String> getPackageVersion() async => (await PackageInfo.fromPlatform()).version;

  String currentDynamicLinkHost() {
    switch (_packageInfo.packageName) {
      case _prodPackageName:
        return _prodLinkHost;

      default:
        return _devLinkHost;
    }
  }

  String currentDynamicLinkIsi() {
    switch (_packageInfo.packageName) {
      case _prodPackageName:
        return _prodIsi;

      default:
        return _devIsi;
    }
  }

  BuildMode currentBuildMode() {
    switch (_packageInfo.packageName) {
      case _prodPackageName:
        return BuildMode.prod;

      default:
        return BuildMode.dev;
    }
  }

  String currentBuildBanner() {
    return '${currentBuildMode().toStringLabel()} ${_packageInfo.version}';
  }
}
