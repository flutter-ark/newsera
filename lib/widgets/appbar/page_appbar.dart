import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsera/utils/common/size_util.dart';

// ignore: must_be_immutable
class PageAppbar extends StatelessWidget {
  PageAppbar({this.title, @required this.onPressed});
  String title;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(10.0)),
                color: Colors.black54,
              ),
              child: SvgPicture.asset(
                "assets/icons/chevron-left.svg",
                color: Colors.white,
                width: getProportionateScreenWidth(20.0),
              ),
            ),
          ),
          Text(
            title ?? "",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
          ),
          SizedBox(width: getProportionateScreenWidth(20.0)),
        ],
      ),
    );
  }
}
