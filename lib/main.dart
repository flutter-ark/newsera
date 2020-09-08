import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsera/config/theme.dart';
import 'package:newsera/enums/connectivity_status.dart';
import 'package:newsera/providers/genesis.dart';
import 'package:newsera/providers/theme_provider.dart';
import 'package:newsera/routes/main_routes.dart';
import 'package:newsera/screens/common/connectivity_screen.dart';
import 'package:newsera/screens/common/splash_screen.dart';
import 'package:newsera/services/connectivity_services.dart';
import 'package:newsera/utils/newtork/check_connectivity.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MultiProvider(
        providers: providers,
        child: StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
          child: Newsera(),
        ),
      ),
    ),
  );
}

class Newsera extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _NewseraState createState() => _NewseraState();
}

class _NewseraState extends State<Newsera> with SingleTickerProviderStateMixin {
  void initState() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(ConnectivityScreen.id, (route) => false);
      }
    });
    CheckConnectivity().status().then((value) {
      if (!value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(ConnectivityScreen.id, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
        title: 'Newsera',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        themeMode:
            themeProvider.isLightTheme ? ThemeMode.light : ThemeMode.dark,
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
