import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network("https://picsum.photos/200/300", fit: BoxFit.cover),
          ),
        ),
        Text(
          "Russian warship: Moskva sinks in Black Sea",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Row(spacing: 10, children: [Icon(Icons.alarm_add), Text("4hr Ago")]),
      ],
    );
  }
}