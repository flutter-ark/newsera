import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsera/screens/post/bookmark_screen.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/appbar/page_appbar.dart';
import 'package:newsera/widgets/common/custom_menu_tile.dart';

class MenuScreen extends StatelessWidget {
  static const id = " menu_screen";
  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    return Material(
      child: Container(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(20.0)),
        width: double.infinity,
        height: SizeUtil.screenHeight,
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getProportionateScreenHeight(100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    getProportionateScreenWidth(30),
                  ),
                  bottomRight: Radius.circular(
                    getProportionateScreenWidth(30),
                  ),
                ),
              ),
              child: PageAppbar(
                onPressed: () => Navigator.of(context).pop(),
                title: "Newsera",
              ),
            ),
            Flexible(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                ),
                children: [
                  CustomMenuTile(
                    leading: SvgPicture.asset(
                      "assets/icons/bookmark-alt.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                    label: "Bookmarks",
                    onPressed: () =>
                        Navigator.of(context).pushNamed(PostBookmarkScreen.id),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/qrcode.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Text(
                    "Version 1.0.0",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
