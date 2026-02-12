import 'package:flutter/material.dart';

extension StringPercent on String {
  String toPercent() {
    final numValue = double.tryParse(this);
    if (numValue == null) return '0%'; // fallback for invalid input
    return '${(numValue * 100).round()}%';
  }

  Color toColor() {
    final numValue = double.tryParse(this) ?? 0.0;
    return numValue >= 0.7
        ? Colors.green
        : numValue >= 0.4 && numValue < 0.7
        ? Colors.yellow
        : Colors.orange;
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
