import 'package:flutter/material.dart';
import 'package:newsera/config/api_config.dart';
import 'package:newsera/models/post_model.dart';
import 'package:newsera/utils/newtork/api_call.dart';

class CategoryProvider with ChangeNotifier {
  List<String> _categories = [
    "All",
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];
  List<PostModel> _postByCategory = [];

  // get a copy of categories list
  List<String> get getCategories => [..._categories];

  // add a record to category list
  void addToCategories(String record) {
    _categories.add(record);
    notifyListeners();
  }

  // get news based on category
  Future<List<PostModel>> fetchNewsByCategory(String category) async {
    try {
      var url =
          "$baseUrl/top-headlines?country=in&category=${category.toLowerCase()}";
      return await ApiCall().getData(url).then((data) {
        if (data["status"] == "ok") {
          try {
            _postByCategory.clear();
            data['articles'].forEach(
              (article) {
                _postByCategory.add(
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
            return _postByCategory;
          } catch (e) {
            print("error inside adding article to postByCategory: $e");
          }
        }
      });
    } catch (e) {
      print("error inside fetching postByCategory api: $e");
    }
    return [..._postByCategory];
  }
}
