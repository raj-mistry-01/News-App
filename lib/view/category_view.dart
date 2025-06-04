import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/view/home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.category,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 16), // Add spacing
                    // Articles section
                    articles.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text("No articles found"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              );
                            },
                            itemCount: articles.length,
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
