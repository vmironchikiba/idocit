import 'package:flutter/cupertino.dart';

class LoggerService {
  static void logDebug(String message) {
    final time = DateTime.now();
    final formattedTime = '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}';
    debugPrint('***** $formattedTime > $message');
  }
}
