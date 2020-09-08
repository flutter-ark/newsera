import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsera/providers/post_provider.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/appbar/page_appbar.dart';
import 'package:newsera/widgets/cards/girdViewPostCard.dart';
import 'package:newsera/widgets/cards/listVIewPostCard.dart';
import 'package:provider/provider.dart';

class PostBookmarkScreen extends StatefulWidget {
  static const id = "post_bookmark_screen";
  @override
  _PostBookmarkScreenState createState() => _PostBookmarkScreenState();
}

class _PostBookmarkScreenState extends State<PostBookmarkScreen> {
  bool _isListView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: SizeUtil.screenWidth,
        height: SizeUtil.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20.0)),
            PageAppbar(
                onPressed: () => Navigator.of(context).pop(),
                title: "Bookmarked Articles"),
            SizedBox(height: getProportionateScreenHeight(20.0)),
            buildViewFIlterUi(),
            SizedBox(height: getProportionateScreenHeight(20.0)),
            buildRecordListingUi(),
          ],
        ),
      ),
    ));
  }

  Flexible buildRecordListingUi() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) => postProvider
                      .getBookmarkedRecords.length >
                  0
              ? (_isListView)
                  ? AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              ScaleTransition(child: child, scale: animation),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (sbtx, index) => ListViewPostCard(
                            post: postProvider.getBookmarkedRecords[index]),
                        separatorBuilder: (sbtx, context) => SizedBox(
                          height: getProportionateScreenHeight(30.0),
                        ),
                        itemCount: postProvider.getBookmarkedRecords.length,
                      ),
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              ScaleTransition(child: child, scale: animation),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(
                          postProvider.getBookmarkedRecords.length,
                          (index) {
                            return GridViewPostCard(
                                post: postProvider.getBookmarkedRecords[index]);
                          },
                        ),
                      ),
                    )
              : Container(
                  child: Center(
                    child: Text("Nothing here"),
                  ),
                ),
        ),
      ),
    );
  }

  Padding buildViewFIlterUi() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isListView = !_isListView),
            child: SvgPicture.asset(
              "assets/icons/view-list.svg",
              width: getProportionateScreenWidth(30),
              color: _isListView ? Colors.black : Colors.grey,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10.0)),
          GestureDetector(
            onTap: () => setState(() => _isListView = !_isListView),
            child: SvgPicture.asset(
              "assets/icons/view-grid.svg",
              width: getProportionateScreenWidth(30),
              color: !_isListView ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
