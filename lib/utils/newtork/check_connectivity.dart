import 'package:connectivity/connectivity.dart';
import 'dart:io';

class CheckConnectivity {
  ConnectivityResult previous;

  Future<bool> status() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
    return await Future.value(false);
  }
}
