import 'package:flutter/material.dart';

class PostModel {
  SourceMode source;
  String author, title, description, url, urlToImage, publishedAt, content;
  bool isBookMarked;
  PostModel({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.content,
    @required this.isBookMarked,
  });
}

class SourceMode {
  final String id, name;
  SourceMode({this.id, @required this.name});
}
