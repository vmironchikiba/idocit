import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:flutter/foundation.dart' show FlutterError;

class FirebaseService {
  final DeviceService deviceService;
  late final FirebaseAnalytics _analytics;
  late final FirebaseCrashlytics _crashlytics;

  FirebaseService({required this.deviceService});

  Future<void> init() async {
    LoggerService.logDebug('FirebaseService -> init()');

    await Firebase.initializeApp();
    _crashlytics = FirebaseCrashlytics.instance;
    _analytics = FirebaseAnalytics.instance;

    await _startCrashlytics();
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  Future<void> logFirebaseEvent({required String name, Map<String, Object?>? parameters}) async {
    var parametersUpdated = Map<String, Object?>.from(parameters ?? {});
    parametersUpdated['package'] = await deviceService.getPackageName();
    return _analytics.logEvent(name: name, parameters: parametersUpdated);
  }

  Future<void> setUserId(String id) => _analytics.setUserId(id: id);
  Future<void> setUserProperty({required String name, required String? value}) =>
      _analytics.setUserProperty(name: name, value: value);

  Future<void> _startCrashlytics() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = _crashlytics.recordFlutterError;

    /// To catch errors that happen outside of the Flutter context
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await _crashlytics.recordError(errorAndStacktrace.first, errorAndStacktrace.last);
      }).sendPort,
    );
  }
}
