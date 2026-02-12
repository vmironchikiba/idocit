enum InAppFailureType { network, backend, web, linkProviders }

enum InAppFailureTypeExtended { primary, network, backend, web, linkProviders }

extension InAppFailureTypeExtention on InAppFailureType {
  InAppFailureTypeExtended toExtended() {
    switch (this) {
      case InAppFailureType.network:
        return InAppFailureTypeExtended.network;

      case InAppFailureType.backend:
        return InAppFailureTypeExtended.backend;

      case InAppFailureType.web:
        return InAppFailureTypeExtended.web;

      case InAppFailureType.linkProviders:
        return InAppFailureTypeExtended.linkProviders;
    }
  }

  String getTitle() {
    switch (this) {
      case InAppFailureType.network:
        return 'Lost connection';

      case InAppFailureType.backend:
        return 'Something went wrong';

      case InAppFailureType.web:
        return 'Ooops...';

      case InAppFailureType.linkProviders:
        return 'Ooops!';
    }
  }

  String getDescription() {
    switch (this) {
      case InAppFailureType.network:
        return 'Please check your internet connection and try again.';

      case InAppFailureType.backend:
        return 'Please try again later.';

      case InAppFailureType.web:
        return 'Utility Connection Unavailable:\nTry Again Later.';

      case InAppFailureType.linkProviders:
        return 'Link Provider Connection Unavailable:\nTry Again Later.';
      // switch (provider) {
      //   case ConsumptionProviderType.lbs:
      //     return 'Live Building is not available right now, please try again later.';

      //   case ConsumptionProviderType.coned:
      //     return 'ConEd is not available right now, please try again later.';

      //   default:
      //     return 'Provider is not available right now, please try again later.';
      // }
    }
  }

  String getButtonTitle() {
    switch (this) {
      case InAppFailureType.network:
        return 'Try again';

      case InAppFailureType.backend:
        return 'Try again';

      case InAppFailureType.web:
        return 'Try Later';

      case InAppFailureType.linkProviders:
        return 'Ok';
    }
  }
}

class InAppFailureData {
  final Function() onError;
  final InAppFailureType type;

  const InAppFailureData({required this.onError, required this.type});

  factory InAppFailureData.network({required Function() onError}) {
    return InAppFailureData(onError: onError, type: InAppFailureType.network);
  }

  factory InAppFailureData.backend({required Function() onError}) {
    return InAppFailureData(onError: onError, type: InAppFailureType.backend);
  }

  factory InAppFailureData.webview({required Function() onError}) {
    return InAppFailureData(onError: onError, type: InAppFailureType.web);
  }

  factory InAppFailureData.linkProviders({required Function() onError}) {
    return InAppFailureData(onError: onError, type: InAppFailureType.linkProviders);
  }
}

class InAppFailureOptions {
  final InAppFailureTypeExtended type;
  final Function()? onGoBack;
  final Function()? onGoNext;
  // final ConsumptionType? consumptionType;
  // final ConsumptionProviderType? provider;
  final bool isImportant;

  const InAppFailureOptions({
    required this.type,
    this.onGoBack,
    this.onGoNext,
    // this.consumptionType,
    // this.provider,
    this.isImportant = false,
  });
}
