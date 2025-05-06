import 'package:bca_project/models/article.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});

  final Article
  article; //yasma article ko type map<string, dynamic> xa jun chai hamla postman bta thaa pako

  @override
  Widget build(BuildContext context) {
    // debugPrint(article.toString());
    //yadi article vanna models na vako vaya talako concept use huntheeyo
    // String cover = article['Cover']['url'];
    //cover variable ma article ko
    //yaslai map of string dynamic ma rakhyara ani tala $cover ko place ma $coverurl rakhna parxa
    //Map<string, dynamic> cover = article['cover];
    // String coverUrl = cover['url'];
    return Column(
      spacing: 10,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              "http://10.0.2.2:1337${article.coverImageUrl}",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          article.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Row(
          spacing: 10,
          children: [
            Icon(Icons.alarm),
            Text(timeago.format(article.publishedAt)),
          ],
        ), //import timeago package in flutter
      ],
    );
  }
}
