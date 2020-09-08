import 'dart:async';
import 'package:connectivity/connectivity.dart';
import '../enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Convert the result to enum
      var connectivityStatus = _getStatusFromResult(result);

      // now broadcast the value over stream to the app
      connectionStatusController.add(connectivityStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;

      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;

      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;

      default:
        return ConnectivityStatus.Offline;
    }
  }
}
