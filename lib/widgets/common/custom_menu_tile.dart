import 'package:flutter/material.dart';
import 'package:newsera/utils/common/size_util.dart';

// ignore: must_be_immutable
class CustomMenuTile extends StatelessWidget {
  var label;
  var trailing;
  var leading;
  Function onPressed;
  CustomMenuTile({
    this.leading,
    this.label,
    this.trailing,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(18),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: leading,
                ),
                SizedBox(
                  width:
                      (leading != null) ? getProportionateScreenWidth(10.0) : 0,
                ),
                Expanded(
                  child: Text(
                    label,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: getProportionateScreenWidth(16)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
              vertical: getProportionateScreenWidth(10),
            ),
            child: trailing,
          ),
        ],
      ),
    );
  }
}
