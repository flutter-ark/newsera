import 'package:flutter/material.dart';
import 'package:newsera/config/api_config.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/utils/newtork/api_call.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _myFavourites = [];
  List<PostModel> _latestNews = [];
  int currentPage = 1, previousPage = 1, totalRecords = 0;
  PostModel record;

  List<PostModel> get getBookmarkedRecords => [..._myFavourites];
  List<PostModel> get getLatestNews => [..._latestNews];

  void toggleBookmarkStatus(PostModel post) {
    if (_myFavourites.contains(post) && post.isBookMarked == true) {
      // remove the records
      _myFavourites.removeWhere((x) => x.title == post.title);
    } else {
      //add the records
      _myFavourites.add(post);
    }
    post.isBookMarked = !post.isBookMarked;
    notifyListeners();
  }

  bool isBookMarked(post) {
    record =
        _myFavourites.firstWhere((x) => x.title == post.title, orElse: null);
    print("post $record");
    (record != null) ? print(true) : print(false);
    return true;
  }

  // get news based on category
  Future<List<PostModel>> fetchNews(int pageSize, String category) async {
    try {
      var url =
          "$baseUrl/top-headlines?country=in&category=$category&pageSize=$pageSize&page=$currentPage";
      // print(url);
      return await ApiCall().getData(url).then((data) {
        if (data["status"] == "ok") {
          try {
            data['articles'].forEach(
              (article) {
                _latestNews.add(
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
            if (pageSize < totalRecords) {
              previousPage = currentPage;
              currentPage = currentPage++;
            }
            return _latestNews;
          } catch (e) {
            print("error inside adding article to latestNews: $e");
          }
        }
      });
    } catch (e) {
      print("error inside fetching latestNews api: $e");
    }
    return [..._latestNews];
  }

  // get news based on category
  Future<List<PostModel>> fetchLatestNews() async {
    try {
      var url = "$baseUrl/top-headlines?country=in&pageSize=5&page=5";
      // print(url);
      return await ApiCall().getData(url).then((data) {
        if (data["status"] == "ok") {
          try {
            _latestNews.clear();
            data['articles'].forEach(
              (article) {
                _latestNews.add(
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
            return _latestNews;
          } catch (e) {
            print("error inside adding article to latestNews: $e");
          }
        }
      });
    } catch (e) {
      print("error inside fetching latestNews api: $e");
    }
    return [..._latestNews];
  }
}
