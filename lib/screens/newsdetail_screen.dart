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
  bool isExpanded = false;
  List<Article> articles = [];


   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.article.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
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
            AnimatedCrossFade(
              firstChild: Text(
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                widget.article.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              secondChild: Text(
                widget.article.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              crossFadeState:
                  isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: Duration(microseconds: 1200),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  isExpanded ? "Read Less >>" : "Read More >>",
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
