import 'package:bca_project/models/article.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsdetailScreen extends StatefulWidget {
  const NewsdetailScreen({super.key, required this.article});
  final Article article;

  @override
  State<NewsdetailScreen> createState() => _NewsdetailScreenState();
}

class _NewsdetailScreenState extends State<NewsdetailScreen> {
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.article.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          children: [
            AspectRatio(
              aspectRatio: 18 / 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "http://10.0.2.2:1337${widget.article.coverImageUrl}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.article.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.alarm),
                Text(
                  timeago.format(widget.article.publishedAt),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              maxLines: 7,
              widget.article.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Read More>>",
                  style: TextStyle(
                    wordSpacing: 5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
