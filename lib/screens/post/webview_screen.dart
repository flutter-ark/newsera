import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostWebViewScreen extends StatefulWidget {
  static const id = "post_screen";

  @override
  _PostWebViewScreenState createState() => _PostWebViewScreenState();
}

class _PostWebViewScreenState extends State<PostWebViewScreen> {
  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: IndexedStack(
        index: position,
        children: <Widget>[
          WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
            gestureNavigationEnabled: true,
          ),
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
