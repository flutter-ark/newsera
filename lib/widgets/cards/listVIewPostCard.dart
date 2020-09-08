import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/screens/post/detail_screen.dart';
import 'package:newsera/utils/common/size_util.dart';

class ListViewPostCard extends StatelessWidget {
  final PostModel post;
  const ListViewPostCard({
    @required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(PostDetailScreen.id, arguments: post),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              imageUrl: post.urlToImage ??
                  'https://source.unsplash.com/random/1024x768',
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: post.title ?? "",
                  child: Text(
                    post.title ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text(
                  "- ${DateFormat.yMMMd().format(DateTime.parse(post.publishedAt))} (${post.source.name})",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
