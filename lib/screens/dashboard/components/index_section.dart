import 'package:flutter/material.dart';
import 'package:newsera/screens/dashboard/components/latest_post.dart';
import 'package:newsera/screens/dashboard/components/post_by_category.dart';
import 'package:newsera/utils/common/size_util.dart';

class IndexSectionUI extends StatefulWidget {
  @override
  _IndexSectionUIState createState() => _IndexSectionUIState();
}

class _IndexSectionUIState extends State<IndexSectionUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(100.0),
          ),
          Text(
            "Today",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: getProportionateScreenHeight(30.0)),
          PostByCategoriesUi(),
          SizedBox(height: getProportionateScreenHeight(30.0)),
          LatestPostsUi(),
        ],
      ),
    );
  }
}
