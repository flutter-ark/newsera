import 'package:flutter/material.dart';
import 'package:newsera/utils/common/size_util.dart';

class SectionTitleUi extends StatelessWidget {
  final String title;
  final double hPadding;
  SectionTitleUi({
    @required this.title,
    @required this.hPadding,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(hPadding)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            color: Colors.black,
            width: SizeUtil.screenWidth * 0.10,
            height: getProportionateScreenHeight(2),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }
}
