import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/injection_container.dart';

class NetworkListenerService {
  final _connectivity = Connectivity();
  bool _isConnected = true;

  void listenNetworkChanges() {
    LoggerService.logDebug('NetworkStatusHandler -> listenNetworkChanges()');
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.bluetooth) {
        return;
      }

      if (event == ConnectivityResult.none && _isConnected) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
    });
  }

  Future<bool> checkNetworkConnection(Future<Either<Failure, dynamic>> Function()? onErrorCallback) async {
    bool isNetworkEnabled = (await _connectivity.checkConnectivity()) != ConnectivityResult.none;
    if (isNetworkEnabled) return true;

    await Future.delayed(const Duration(seconds: 5));
    isNetworkEnabled = (await _connectivity.checkConnectivity()) != ConnectivityResult.none;

    if (!isNetworkEnabled) {
      LoggerService.logDebug('FAILURE: NetworkStatusHandler -> checkNetworkConnection() no connection');
      // if (onErrorCallback != null) {
      //   locator<InAppFailureProvider>().addFailure(
      //     InAppFailureData.network(onError: onErrorCallback),
      //     options: InAppFailureOptions(type: InAppFailureTypeExtended.network, consumptionType: type),
      //   );
      // }
    }

    return isNetworkEnabled;
  }
}
