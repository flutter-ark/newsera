import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsera/config/api_config.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/utils/common/size_util.dart';
import 'package:newsera/utils/newtork/api_call.dart';
import 'package:newsera/widgets/cards/girdViewPostCard.dart';
import 'package:newsera/widgets/cards/listVIewPostCard.dart';

class SearchScreen extends StatefulWidget {
  static const id = "search_screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PostModel> _records = [];
  bool _isListView = true;
  TextEditingController _searchTextController = TextEditingController();
  bool _isLoading = false;
  int previousPage = 0;
  int currentPage = 1;
  double lastPage = 0;
  int totalRecords = 0;
  int pageSize = 20;
  bool isLoading = false;
  ScrollController _gridScrollController = ScrollController();
  ScrollController _listScrollController = ScrollController();

  @override
  void dispose() {
    _listScrollController.dispose();
    _gridScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _gridScrollController.addListener(() {
      var triggerFetchMoreSize =
          0.99 * _gridScrollController.position.maxScrollExtent;
      if (_gridScrollController.position.pixels > triggerFetchMoreSize) {
        if (lastPage > currentPage || lastPage == 0) {
          setState(() {
            _isLoading = true;
            fetchLiveData(currentPage + 1);
          });
        }
      }
    });
    _listScrollController.addListener(() {
      var triggerFetchMoreSize =
          0.99 * _listScrollController.position.maxScrollExtent;
      if (_listScrollController.position.pixels > triggerFetchMoreSize) {
        if (lastPage > currentPage || lastPage == 0) {
          setState(() {
            _isLoading = true;
            fetchLiveData(currentPage + 1);
          });
        }
      }
    });
  }

  void resetPagination() {
    setState(() {
      _records.clear();
      _isLoading = true;
      currentPage = 1;
      lastPage = 0;
      totalRecords = 0;
      pageSize = 20;
    });
  }

  void fetchLiveData(int cp) async {
    print("new currentPage $cp");
    print("currentPage $currentPage");
    print("previousPage $previousPage");
    print("totalRecords $totalRecords");
    print("lastPage $lastPage");
    print("__________________________________");
    if (_isLoading && cp > previousPage) {
      setState(() {
        _isLoading = true;
        previousPage = currentPage;
        currentPage = cp;
      });
      print("__________________________________");
      print("-new currentPage $cp");
      print("-currentPage $currentPage");
      print("-previousPage $previousPage");
      print("__________________________________");
      try {
        var url =
            "$baseUrl/everything?q=${_searchTextController.text}&pageSize=$pageSize&page=$cp";
        print(url);
        ApiCall().getData(url).then((data) {
          if (data["status"] == "ok") {
            try {
              data['articles'].forEach(
                (article) {
                  _records.add(
                    PostModel(
                      source: SourceMode(
                          id: article['source']['id'],
                          name: article['source']['name']),
                      author: article['author'],
                      title: article['title'],
                      description: article['description'],
                      url: article['url'],
                      urlToImage: article['urlToImage'],
                      publishedAt: article['publishedAt'],
                      content: article['content'],
                      isBookMarked: false,
                    ),
                  );
                },
              );
              setState(() {
                _isLoading = false;
                totalRecords = data['totalResults'];
                lastPage = data['totalResults'] / pageSize;
              });
            } catch (e) {
              print("error inside adding article to latestNews: $e");
            }
          }
        });
      } catch (e) {
        print("error inside fetching latestNews api: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: SizeUtil.screenWidth,
        height: SizeUtil.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20.0)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10.0)),
                        color: Colors.black54,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/chevron-left.svg",
                        color: Colors.white,
                        width: getProportionateScreenWidth(20.0),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _searchTextController,
                      autofocus: true,
                      // onChanged: (content) {
                      //   if (content.length > 2) {
                      //     setState(() {
                      //       _searchTextController.text = content;
                      //     });
                      //   }
                      // },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Search ...'),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      semanticLabel: 'click to clear start search',
                    ),
                    onPressed: () => setState(() {
                      _isLoading = true;
                      fetchLiveData(currentPage);
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20.0)),
            buildViewFIlterUi(),
            SizedBox(height: getProportionateScreenHeight(20.0)),
            buildRecordListingUi(),
            _isLoading
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(child: child, scale: animation),
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20.0)),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }

  Flexible buildRecordListingUi() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
        child: (_records.length > 0)
            ? (_isListView)
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(child: child, scale: animation),
                    child: ListView.separated(
                      controller: _listScrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (sbtx, index) =>
                          ListViewPostCard(post: _records[index]),
                      separatorBuilder: (sbtx, context) => SizedBox(
                        height: getProportionateScreenHeight(30.0),
                      ),
                      itemCount: _records.length,
                    ),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(child: child, scale: animation),
                    child: GridView.count(
                      crossAxisCount: 2,
                      controller: _gridScrollController,
                      children: List.generate(
                        _records.length,
                        (index) {
                          return GridViewPostCard(post: _records[index]);
                        },
                      ),
                    ),
                  )
            : Container(
                child: Center(
                  child: Text("..."),
                ),
              ),
      ),
    );
  }

  Padding buildViewFIlterUi() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isListView = !_isListView),
            child: SvgPicture.asset(
              "assets/icons/view-list.svg",
              width: getProportionateScreenWidth(30),
              color: _isListView ? Colors.black : Colors.grey,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10.0)),
          GestureDetector(
            onTap: () => setState(() => _isListView = !_isListView),
            child: SvgPicture.asset(
              "assets/icons/view-grid.svg",
              width: getProportionateScreenWidth(30),
              color: !_isListView ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
