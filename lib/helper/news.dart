import 'dart:convert';

import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String apiurl =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e3dae2b9519c4ce995724d228ff00b9c";

    var response = await http.get(Uri.parse(apiurl));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'] ?? "",
            author: element['author'] ?? "", // avoid null error here
            description: element['description'] ?? "",
            url: element['url'] ?? "",
            urlToImage: element['urlToImage'] ?? "",
            content: element['content'] ?? "",
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    print(category);
    print("yes");
    String apiurl =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=e3dae2b9519c4ce995724d228ff00b9c";

    var response = await http.get(Uri.parse(apiurl));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'] ?? "",
            author: element['author'] ?? "", // avoid null error here
            description: element['description'] ?? "",
            url: element['url'] ?? "",
            urlToImage: element['urlToImage'] ?? "",
            content: element['content'] ?? "",
          );
          news.add(articleModel);
        }
      });
    }
  }
}
