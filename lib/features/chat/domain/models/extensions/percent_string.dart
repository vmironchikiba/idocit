extension StringPercent on String {
  String toPercent() {
    final numValue = double.tryParse(this);
    if (numValue == null) return '0%'; // fallback for invalid input
    return '${(numValue * 100).round()}%';
  }
}
