import 'package:flutter/material.dart';
import 'package:idocit/common/services/logger.dart';

enum ThemeStyleType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeStyleType _type = ThemeStyleType.light;

  ThemeStyleType get type => _type;

  void update({ThemeStyleType? type}) {
    LoggerService.logDebug('ThemeProvider -> update(type: $type)');
    if (_type == type) {
      return;
    }

    _type = type ?? _type;
    notifyListeners();
  }
}
