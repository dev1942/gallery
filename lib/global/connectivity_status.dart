import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatus {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> isConnected() async {
    String mConnectionStatus;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mConnectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (e) {
      log(e.toString());
      mConnectionStatus = 'Failed to get connectivity.';
    }

    bool connectionStatus = false;

    if (mConnectionStatus.isNotEmpty) {
      if (mConnectionStatus == ConnectivityResult.mobile.toString()) {
        // I am connected to a mobile network.
        connectionStatus = true;
      } else if (mConnectionStatus == ConnectivityResult.wifi.toString()) {
        // I am connected to a wifi network.
        connectionStatus = true;
      } else {
        connectionStatus = false;
      }
    }

    return connectionStatus;
  }
}
