import 'package:flutter/material.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/providers/category_provider.dart';
import 'package:newsera/screens/post/list_by_category.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/widgets/cards/postCartW200.dart';
import 'package:provider/provider.dart';

class PostByCategoriesUi extends StatefulWidget {
  @override
  _PostByCategoriesUiState createState() => _PostByCategoriesUiState();
}

class _PostByCategoriesUiState extends State<PostByCategoriesUi> {
  double currentCategoryIndex = 0.0;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    _pageController
      ..addListener(
          () => setState(() => currentCategoryIndex = _pageController.page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) => SizedBox(
            width: double.infinity,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProvider.getCategories.length,
              itemBuilder: (btx, index) {
                return (categoryProvider.getCategories.length > 0)
                    ? GestureDetector(
                        onTap: () => _pageController.animateToPage(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear),
                        child: Container(
                          margin: EdgeInsets.only(
                              right: getProportionateScreenWidth(20)),
                          child: Text(
                            categoryProvider.getCategories[index],
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: (currentCategoryIndex == index)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        SizedBox(
          height: getProportionateScreenHeight(250),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) => PageView.builder(
              controller: _pageController,
              itemCount: categoryProvider.getCategories.length,
              itemBuilder: (btx, position) {
                return FutureBuilder<List<PostModel>>(
                  future: categoryProvider.fetchNewsByCategory((position > 0)
                      ? categoryProvider.getCategories[position]
                      : ""),
                  builder: (btx, snapshot) {
                    switch (snapshot.connectionState) {
                      case (ConnectionState.active):
                      case (ConnectionState.waiting):
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case (ConnectionState.done):
                        return (snapshot.hasData && snapshot.data.length > 0)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (btx, index) {
                                  return (index < 4)
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              right:
                                                  getProportionateScreenWidth(
                                                      20)),
                                          child: PostCardW200(
                                              post: snapshot.data[index]),
                                        )
                                      : GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  PostlistedByCategory.id,
                                                  arguments: categoryProvider
                                                      .getCategories[position]),
                                          child: Container(
                                            width: getProportionateScreenWidth(
                                                200),
                                            padding: EdgeInsets.all(
                                                getProportionateScreenWidth(
                                                    20)),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    getProportionateScreenWidth(
                                                        20.0))),
                                            child: Center(
                                              child: Text("Show More"),
                                            ),
                                          ),
                                        );
                                })
                            : Container(
                                child: Center(
                                  child: Text(
                                      "No Post Found for ${categoryProvider.getCategories[position]}"),
                                ),
                              );
                      default:
                        return Container(
                          child: Center(
                            child: Text("No Post Available !"),
                          ),
                        );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
