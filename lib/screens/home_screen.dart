import 'dart:convert';

import 'package:bca_project/widgets/news_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticlesFromApi();
  }

  void fetchArticlesFromApi() async {
    var url = Uri.parse("http://localhost:1337/api/articles/?populate=*");
    http.Response result = await http.get(url);
    Map<String, dynamic> decodedResult = jsonDecode(result.body);

    List data = decodedResult['data'];

    for (int i = 0; i < data.length; i++) {
      articles.add(data[i]);
    }
    setState(() {
      
    });
    // debugPrint("the length of article s is  ${articles.length}"")
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: ListView.separated(//seperated la chai 2ta list ko bich ma gap dinxa ani seperatorbuilder dinxa
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => SizedBox(height: 40),
        itemBuilder: (_, int index) {
          return NewsCard(article: articles[index]);
        },
      ),
    );
  }
}
