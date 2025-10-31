import 'package:flutter/cupertino.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/constants/errors.dart';

enum InAppToastType { warningBadConfirmationCode, warning, network, empty }

class InAppToastData {
  final int id;
  final ValueKey<String> key;
  final InAppToastType type;
  final String message;

  const InAppToastData({required this.id, required this.key, required this.type, required this.message});

  InAppToastData empty() {
    return InAppToastData(id: DateTime.now().hashCode, key: key, type: InAppToastType.empty, message: 'Empty');
  }

  factory InAppToastData.create({required ValueKey<String> key, required String message}) {
    return InAppToastData(id: DateTime.now().hashCode, key: key, type: InAppToastType.warning, message: message);
  }

  factory InAppToastData.createFromFailure({required ValueKey<String> key, required Failure failure}) {
    if (failure is HTTPFailure) {
      return InAppToastData(
        id: DateTime.now().hashCode,
        key: key,
        type: failure.type == HttpErrorType.badConfirmationCode
            ? InAppToastType.warningBadConfirmationCode
            : InAppToastType.warning,
        message: failure.comment ?? failure.message,
      );
    }

    if (failure is NetworkFailure) {
      return InAppToastData(
        id: DateTime.now().hashCode,
        key: key,
        type: InAppToastType.network,
        message: failure.message,
      );
    }

    return InAppToastData(
      id: DateTime.now().hashCode,
      key: key,
      type: InAppToastType.warning,
      message: failure.message,
    );
  }
}
