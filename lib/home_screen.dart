import 'package:bca_project/widgets/news_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchArticlesFromApi();
  // }

  // void fetchArticlesFromApi() async {
  //   var url = Uri.parse("http://localhost:1300/api/articles/");
  //   http.Response result = await http.get(url);
  //   debugPrint(result.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: ListView.separated(
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => SizedBox(height: 40),
        itemBuilder: (_, int index) {
          return NewsCard();
        },
      ),
    );
  }
}