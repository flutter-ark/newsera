import 'package:newsera/screens/common/connectivity_screen.dart';
import 'package:newsera/screens/common/menu_screen.dart';
import 'package:newsera/screens/common/search_screen.dart';
import 'package:newsera/screens/common/splash_screen.dart';
import 'package:newsera/screens/dashboard/home_screen.dart';
import 'package:newsera/screens/post/bookmark_screen.dart';
import 'package:newsera/screens/post/detail_screen.dart';
import 'package:newsera/screens/post/list_by_category.dart';
import 'package:newsera/screens/post/webview_screen.dart';

var routes = {
  SplashScreen.id: (context) => SplashScreen(),
  HomeScreen.id: (context) => HomeScreen(),
  ConnectivityScreen.id: (context) => ConnectivityScreen(),
  PostDetailScreen.id: (context) => PostDetailScreen(),
  PostlistedByCategory.id: (context) => PostlistedByCategory(),
  PostWebViewScreen.id: (context) => PostWebViewScreen(),
  PostBookmarkScreen.id: (context) => PostBookmarkScreen(),
  SearchScreen.id: (context) => SearchScreen(),
  MenuScreen.id: (context) => MenuScreen(),
};
