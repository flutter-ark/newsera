import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/screens/post/detail_screen.dart';
import 'package:newsera/utils/common/size_util.dart';

class PostCardW200 extends StatelessWidget {
  final PostModel post;
  PostCardW200({@required this.post});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(PostDetailScreen.id, arguments: post),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: getProportionateScreenWidth(300),
          height: getProportionateScreenHeight(280),
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: SizeUtil.screenWidth * 0.80,
                height: SizeUtil.screenWidth * 0.80,
                imageUrl: post.urlToImage ??
                    'https://source.unsplash.com/random/1024x768',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1],
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
