import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsera/screens/common/splash_screen.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/utils/newtork/check_connectivity.dart';

class ConnectivityScreen extends StatefulWidget {
  static const id = "connectivity_screen";
  @override
  _ConnectivityScreenState createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousConnectionState;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      print("current connctivity status : $connresult");
      print(
          'checking if previous connectivity was none: $_previousConnectionState');
      if (connresult == ConnectivityResult.none) {
      } else if (_previousConnectionState == ConnectivityResult.none ||
          _previousConnectionState == null) {
        CheckConnectivity().status().then((result) {
          print("domain check result: $result");
          if (result) {
            Navigator.pushNamedAndRemoveUntil(
                context, SplashScreen.id, (route) => false);
          }
        });
      }
      _previousConnectionState = connresult;
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  void checkInternetConnectivity() {
    CheckConnectivity().status().then((result) {
      print(result);
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, SplashScreen.id, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    return Scaffold(
      body: Container(
        width: SizeUtil.screenWidth,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/connected_world.svg',
              height: 200,
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Your Internet Conenction is lost!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Internet Connection is required to use this app!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
