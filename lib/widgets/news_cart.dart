import 'package:bca_project/models/article.dart';
import 'package:bca_project/screens/newsdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatefulWidget {
  const NewsCard({super.key, required this.article});

  final Article article;
  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  //yasma article ko type map<string, dynamic> xa jun chai hamla postman bta thaa pako
  bool isLiked = false;
  bool isBookmarked = false;
  

  @override
  Widget build(BuildContext context) {
    // debugPrint(article.toString());
    //yadi article vanna models na vako vaya talako concept use huntheeyo
    // String cover = article['Cover']['url'];
    //cover variable ma article ko
    //yaslai map of string dynamic ma rakhyara ani tala $cover ko place ma $coverurl rakhna parxa
    //Map<string, dynamic> cover = article['cover'];
    // String coverUrl = cover['url'];
    return Card(
      elevation: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          spacing: 10,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "http://10.0.2.2:1337${widget.article.coverImageUrl}",
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return NewsdetailScreen(article: widget.article);
                    },
                  ),
                );
              },
              child: Text(
                widget.article.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,

                children: [
                  Icon(Icons.alarm),
                  Text(timeago.format(widget.article.publishedAt)),
                  SizedBox(width: 90),
                  IconButton(
                    padding: EdgeInsets.only(right: 15),
                    iconSize: 25,
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                    ),
                    color: isLiked ? Colors.red : Colors.black,
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),

                  SizedBox(width: 15),
                  IconButton(
                    padding: EdgeInsets.only(right: 5),
                    iconSize: 25,
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    color: isBookmarked ? Colors.black : Colors.black,
                    onPressed: () {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
