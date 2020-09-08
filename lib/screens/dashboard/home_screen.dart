import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:newsera/providers/app_provider.dart';
import 'package:newsera/screens/common/connectivity_screen.dart';
import 'package:newsera/screens/common/menu_screen.dart';
import 'package:newsera/screens/common/splash_screen.dart';
import 'package:newsera/screens/dashboard/components/index_section.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/appbar/main_appbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  // for identifing routename
  static const id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup('example.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // internet conn available
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => imageui(),
          // ));
        } else {
          // no conn
          Navigator.pushNamedAndRemoveUntil(
              context, SplashScreen.id, (route) => false);
        }
      }).catchError((error) {
        // no conn
        Navigator.pushNamedAndRemoveUntil(
            context, SplashScreen.id, (route) => false);
      });
    } on SocketException catch (_) {
      // no internet
      Navigator.pushNamedAndRemoveUntil(
          context, SplashScreen.id, (route) => false);
    }

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        // print("connresult :$connresult");
        Navigator.of(context)
            .pushNamedAndRemoveUntil(ConnectivityScreen.id, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(child: child, scale: animation),
                  child: IndexSectionUI()),
              MainAppBar(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(child: child, scale: animation),
                child: Consumer<AppProvider>(
                  builder: (context, appProvider, child) =>
                      appProvider.isMenuOpen ? MenuScreen() : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
