import 'package:flutter/material.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/providers/post_provider.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/cards/listVIewPostCard.dart';
import 'package:newsera/widgets/common/section_title.dart';
import 'package:provider/provider.dart';

class LatestPostsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(900),
      child: Column(
        children: [
          SectionTitleUi(
            title: "Latest News",
            hPadding: 0,
          ),
          Flexible(
            child: Consumer<PostProvider>(
              builder: (context, postProvider, child) =>
                  FutureBuilder<List<PostModel>>(
                future: postProvider.fetchLatestNews(),
                builder: (btx, snapshot) {
                  switch (snapshot.connectionState) {
                    case (ConnectionState.active):
                    case (ConnectionState.waiting):
                      return Container(
                        height: getProportionateScreenHeight(200),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case (ConnectionState.done):
                      return (snapshot.hasData && snapshot.data.length > 0)
                          ? ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (btx, index) => ListViewPostCard(
                                post: snapshot.data[index],
                              ),
                              separatorBuilder: (sbtx, index) => SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              itemCount: 5,
                            )
                          : Container(
                              child: Center(
                                child: Text(
                                    "No latest news available at the moment !"),
                              ),
                            );
                      break;
                    default:
                      return Container(
                        child: Center(
                          child:
                              Text("No latest news available at the moment !"),
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
