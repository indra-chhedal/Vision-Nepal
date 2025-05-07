import 'dart:convert';

import 'package:bca_project/models/article.dart';
import 'package:bca_project/widgets/news_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = []; //list ko type article form ma xa so articles ma data haru list of article ko form ma store hunxa

  @override
  void initState() {
    super.initState();
    fetchArticlesFromApi();
  }

  void fetchArticlesFromApi() async {
    var url = Uri.parse("http://10.0.2.2:1337/api/articles?populate=*");
    http.Response result = await http.get(url);
    Map<String, dynamic> decodedResult = jsonDecode(result.body);
    List data = decodedResult['data'];

    for (int i = 0; i < data.length; i++) {
      articles.add(Article.fromMap(data[i]));
    }

    setState(() {});

    // debugPrint("The length of articles is ${articles.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: ListView.separated(
        itemCount: articles.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        separatorBuilder:
            (_, __) => SizedBox(
              height: 40,
            ), //we can use under score at the place of context and index value in seperator buildor if context is not needed
        itemBuilder: (_, int index) {
          return NewsCard(article: articles[index]);
        },
      ),
    );
  }
}
