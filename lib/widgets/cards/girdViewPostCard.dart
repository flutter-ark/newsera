import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/screens/post/detail_screen.dart';
import 'package:newsera/utils/common/size_util.dart';

class GridViewPostCard extends StatelessWidget {
  final PostModel post;
  GridViewPostCard({@required this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(20.0)),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(PostDetailScreen.id, arguments: post),
          child: Stack(
            children: [
              CachedNetworkImage(
                width: SizeUtil.screenWidth / 2 - 20,
                height: SizeUtil.screenWidth / 2 - 20,
                fit: BoxFit.fitHeight,
                imageUrl: post.urlToImage ??
                    'https://source.unsplash.com/random/1024x768',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black38, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
