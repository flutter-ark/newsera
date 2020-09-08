import 'package:newsera/providers/app_provider.dart';
import 'package:newsera/providers/category_provider.dart';
import 'package:newsera/providers/post_provider.dart';
import 'package:provider/provider.dart';

var providers = [
  ChangeNotifierProvider(
    create: (context) => AppProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => CategoryProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => PostProvider(),
  ),
].toList();
