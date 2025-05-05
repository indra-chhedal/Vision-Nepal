import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});

  final Map<String, dynamic> article;

  @override
  Widget build(BuildContext context) {
    debugPrint(article.toString());

    Map<String, dynamic> cover = article['Cover'];

    String coverUrl = cover['url'];
    return Column(
      spacing: 10,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              "http://10.0.2.2:1337$coverUrl",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          article['Title'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Row(spacing: 10, children: [Icon(Icons.alarm_add), Text("4hr Ago")]),
      ],
    );
  }
}
