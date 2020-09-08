import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/providers/post_provider.dart';
import 'package:newsera/screens/post/webview_screen.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/appbar/page_appbar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class PostDetailScreen extends StatelessWidget {
  static const id = "post_detail_screen";
  @override
  Widget build(BuildContext context) {
    PostModel article = ModalRoute.of(context).settings.arguments;
    SizeUtil().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: SizeUtil.screenHeight,
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: getProportionateScreenHeight(400),
                imageUrl: article.urlToImage ??
                    'https://source.unsplash.com/random/1024x768',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(400),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black12, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              buildPostUi(article, context),
              buildPostBookmarkAndShareUI(context, article),
              Positioned(
                bottom: getProportionateScreenHeight(30.0),
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                        PostWebViewScreen.id,
                        arguments: article.url),
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "Read Complete Article",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(16),
                          ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: getProportionateScreenHeight(20.0),
                  left: 0,
                  child: PageAppbar(
                    onPressed: () => Navigator.of(context).pop(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Column buildPostUi(PostModel article, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getProportionateScreenHeight(150)),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0)),
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(5))),
            child: Text(
              article.source.name ?? "",
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0)),
          child: Hero(
            tag: article.title,
            child: Text(
              article.title ?? "",
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        buildPostAutherSectionUI(context, article),
        buildPostContentUi(context, article),
      ],
    );
  }

  Container buildPostContentUi(BuildContext context, PostModel article) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Text(
        article.description ?? "",
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: getProportionateScreenWidth(16),
              height: getProportionateScreenHeight(2),
              color: Colors.grey,
            ),
      ),
    );
  }

  Container buildPostAutherSectionUI(BuildContext context, PostModel article) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(50.0)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: getProportionateScreenWidth(50),
                  height: getProportionateScreenWidth(50),
                  imageUrl: 'https://source.unsplash.com/random/200x200',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.author ?? "Unknown",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(16)),
                    ),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    Text(
                      "- ${DateFormat.yMMMd().format(DateTime.parse(article.publishedAt))} (${article.source.name})" ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Positioned buildPostBookmarkAndShareUI(
      BuildContext context, PostModel article) {
    return Positioned(
      top: getProportionateScreenHeight(25),
      // top: getProportionateScreenHeight(355),
      left: 0,
      right: 0,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<PostProvider>(
              builder: (context, postProvider, child) => GestureDetector(
                onTap: () => postProvider.toggleBookmarkStatus(article),
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SvgPicture.asset(
                    article.isBookMarked
                        ? "assets/icons/bookmark-solid.svg"
                        : "assets/icons/bookmark.svg",
                    color: Colors.white,
                    width: getProportionateScreenWidth(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            GestureDetector(
              onTap: () =>
                  Share.share('Check out this Article : ${article.url}'),
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SvgPicture.asset(
                  "assets/icons/share.svg",
                  color: Colors.white,
                  width: getProportionateScreenWidth(20.0),
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
