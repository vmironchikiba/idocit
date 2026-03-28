// import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails, PlatformDispatcher;
import 'package:idocit/firebase_options.dart';
import 'package:flutter_udid/flutter_udid.dart';

class FirebaseService {
  final DeviceService deviceService;
  late final FirebaseAnalytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final String _version;
  late final String _packageName;
  late final String _udid;

  FirebaseService({required this.deviceService});

  Future<void> init() async {
    LoggerService.logDebug('FirebaseService -> init()');

    final firebaseApp = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await firebaseApp.setAutomaticDataCollectionEnabled(true);
    final name = firebaseApp.name;
    LoggerService.logDebug('FirebaseService -> name: $name');
    _crashlytics = FirebaseCrashlytics.instance;
    _analytics = FirebaseAnalytics.instance;
    _version = await deviceService.getPackageVersion();
    _packageName = await deviceService.getPackageName();

    try {
      _udid = await FlutterUdid.udid;
    } on PlatformException {
      _udid = 'Failed to get UDID.';
    }

    LoggerService.logDebug('FirebaseService->init->udid:$_udid');

    await _startCrashlytics();
    await _startAnalytics();
  }

  Future<void> _startAnalytics() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
    _analytics.setDefaultEventParameters({
      "app_version": _version,
      "package_name": _packageName,
      "environment": deviceService.currentBuildMode().toString(),
    });
  }

  Future<void> _startCrashlytics() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    // FlutterError.onError = _crashlytics.recordFlutterError;
    FlutterError.onError = (FlutterErrorDetails details) {
      _crashlytics.recordFlutterError(details);
    };

    /// To catch errors that happen outside of the Flutter context
    // Isolate.current.addErrorListener(
    //   RawReceivePort((pair) async {
    //     final List<dynamic> errorAndStacktrace = pair;
    //     await _crashlytics.recordError(errorAndStacktrace.first, errorAndStacktrace.last);
    //   }).sendPort,
    // );

    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
    await setUserIdentifier(_udid);
    await setCustomKey('package_name', _packageName);
  }

  void crash() => _crashlytics.crash();
  Future<void> setUserIdentifier(String id) => _crashlytics.setUserIdentifier(id);
  Future<void> setCustomKey(String key, Object value) => _crashlytics.setCustomKey(key, value);

  Future<void> setUserId(String id) => _analytics.setUserId(id: id);
  Future<void> setUserProperty({required String name, required String? value}) =>
      _analytics.setUserProperty(name: name, value: value);
  Future<void> logFirebaseEvent({required String name, Map<String, Object?>? parameters}) async {
    var parametersUpdated = Map<String, Object?>.from(parameters ?? {});
    parametersUpdated['package'] = await deviceService.getPackageName();
    parametersUpdated['udid'] = _udid;
    return _analytics.logEvent(name: name, parameters: parametersUpdated);
  }
}
