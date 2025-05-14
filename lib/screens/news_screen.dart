import 'dart:convert';

import 'package:bca_project/core/api_constant.dart';
import 'package:bca_project/models/article.dart';
import 'package:bca_project/widgets/news_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Article> articles =
      []; //list ko type article form ma xa so articles ma data haru list of article ko form ma store hunxa

  @override
  void initState() {
    super.initState();
    fetchArticlesFromApi();
  }

  void fetchArticlesFromApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return;
    }

    var url = Uri.parse("http://10.0.2.2:1337/api/articles?populate=*");
    http.Response result = await http.get(
      url,
      headers: {'Authorization': "Bearer $token"},
    );
    Map<String, dynamic> decodedResult = jsonDecode(result.body);
    List data = decodedResult['data'];

    for (int i = 0; i < data.length; i++) {
      articles.add(Article.fromMap(data[i]));
    }

    setState(() {});

    // debugPrint("The data are $data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(26, 248, 244, 244),
      appBar: AppBar(
        title: Text(
          "News Article",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 247, 246, 247),
        foregroundColor: const Color.fromARGB(255, 248, 4, 4),
      ),
      body: ListView.separated(
        itemCount: articles.length,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
