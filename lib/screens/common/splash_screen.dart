import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newsera/screens/common/connectivity_screen.dart';
import 'package:newsera/screens/dashboard/home_screen.dart';
import 'package:newsera/utils/common/size_util.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isConnected;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      _isConnected
          ? Navigator.of(context).pushReplacementNamed(HomeScreen.id)
          : Navigator.of(context).pushReplacementNamed(ConnectivityScreen.id);
    });
  }

  @override
  void didChangeDependencies() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset("assets/images/logo.jpg")),
      ),
    );
  }
}
