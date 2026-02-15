import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_data.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/image.dart';

class InAppFailureProvider with ChangeNotifier {
  final _inProgressEvents = <String>[];
  final _inAppFailures = <InAppFailureData>[];
  final _inAppFailureOptions = <InAppFailureOptions>[];

  InAppFailureType? _primaryType;
  bool _isProcessing = false;

  bool get isShowing => isHaveFailures || _isProcessing;
  bool get isShowingDialog => true; //primaryType == InAppFailureType.linkProviders && isShowing;
  bool get isHaveFailures => _inProgressEvents.isEmpty && _inAppFailures.isNotEmpty;
  bool get isImportant => _inAppFailureOptions.map((option) => option.isImportant).contains(true);

  InAppFailureType? get primaryType {
    final types = _inAppFailures.map((failure) => failure.type).toList();
    types.sort((a, b) => a.index.compareTo(b.index));
    return _primaryType ?? (types.isNotEmpty ? types[0] : null);
  }

  InAppFailureOptions? get primaryOptions {
    final primary = _inAppFailureOptions.firstWhereOrNull((option) => option.type == InAppFailureTypeExtended.primary);
    return primary ?? _inAppFailureOptions.firstWhereOrNull((option) => option.type == primaryType?.toExtended());
  }

  String get iconSrc {
    return ImageConstants.icOnErrorLBS;
    // if (primaryOptions?.provider != null) {
    //   switch (primaryOptions!.provider!) {
    //     case ConsumptionProviderType.lbs:
    //       return ImageConstants.icOnErrorLBS;

    //     case ConsumptionProviderType.coned:
    //       return ImageConstants.icOnErrorConed;
    //   }
    // }

    //   if (primaryOptions?.consumptionType != null) {
    //     switch (primaryOptions!.consumptionType!) {
    //       case ConsumptionType.electricity:
    //         return ImageConstants.icOnErrorElectricity;

    //       case ConsumptionType.water:
    //         return ImageConstants.icOnErrorWater;

    //       case ConsumptionType.fuel:
    //         return ImageConstants.icOnErrorFuel;
    //     }
    //   }

    //   return ImageConstants.icOnErrorConsumptions;
  }

  void addEvent(String event) {
    final isNeedNotify = _inProgressEvents.isEmpty;
    _inProgressEvents.add(event);

    if (isNeedNotify) {
      notifyListeners();
    }
  }

  void removeEvent(String event) {
    _inProgressEvents.remove(event);
    final isNeedNotify = _inProgressEvents.isEmpty;

    if (isNeedNotify) {
      notifyListeners();
    }
  }

  void addOptions(InAppFailureOptions options) {
    if (_inAppFailureOptions.map((option) => option.type).contains(options.type)) {
      _inAppFailureOptions.removeWhere((option) => option.type == options.type);
    }
    _inAppFailureOptions.add(options);
  }

  void addFailure(InAppFailureData failure, {InAppFailureOptions? options}) {
    LoggerService.logDebug('InAppFailureProvider -> addFailure()');
    _inAppFailures.add(failure);
    if (options != null) {
      addOptions(options);
    }
  }

  void clear() {
    LoggerService.logDebug('InAppFailureProvider -> clear()');
    _inProgressEvents.clear();
    _inAppFailures.clear();
    _inAppFailureOptions.clear();
    notifyListeners();
  }

  Future<void> processAllFailures() async {
    LoggerService.logDebug('InAppFailureProvider -> processAllFailures()');
    final failures = _inAppFailures.map((e) => e.onError).toList();
    _primaryType = primaryType;
    _isProcessing = true;

    _inAppFailures.clear();
    await Future.wait(failures.map((e) => e()));

    _isProcessing = false;
    _primaryType = null;
    notifyListeners();

    if (_inAppFailures.isEmpty) {
      _inAppFailureOptions.clear();
    }
  }
}
