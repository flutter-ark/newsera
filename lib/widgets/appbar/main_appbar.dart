import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsera/providers/app_provider.dart';
import 'package:newsera/screens/common/menu_screen.dart';
import 'package:newsera/screens/common/search_screen.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(MenuScreen.id),
            child: SvgPicture.asset(
              "assets/icons/menu-alt-1.svg",
              color: Theme.of(context).textTheme.headline6.color,
            ),
          ),
          Consumer<AppProvider>(
            builder: (context, appProvider, child) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(SearchScreen.id),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
