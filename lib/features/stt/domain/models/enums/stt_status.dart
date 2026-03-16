enum SttStatus { listening, notListening, done }

extension SttStatusToString on SttStatus {
  String get string {
    switch (this) {
      case SttStatus.listening:
        return 'listening';
      case SttStatus.notListening:
        return 'notListening';
      case SttStatus.done:
        return 'done';
    }
  }

  bool? get isStarted => this == SttStatus.listening;
}

extension SttStatusString on String {
  SttStatus? get sttStatus {
    switch (this) {
      case 'listening':
        return SttStatus.listening;
      case 'notListening':
        return SttStatus.notListening;
      case 'done':
        return SttStatus.done;
      default:
        return null;
    }
  }
}
