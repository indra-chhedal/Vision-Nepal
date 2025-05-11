import 'dart:convert';

import 'package:bca_project/models/videos.dart';
import 'package:bca_project/widgets/video_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  List<Videos> videos = [];

  @override
  void initState() {
    fetchVideoFromApi();
    super.initState();
  }

  void fetchVideoFromApi() async {
    var url = Uri.parse("http://10.0.2.2:1337/api/videos/?populate=*");
    http.Response response = await http.get(url);
    Map<String, dynamic> decodedResult = jsonDecode(response.body);
    List data = decodedResult['data'];
    //both lines are written in single line using jsonDecode(response.body)['data'];

    for (int i = 0; i < data.length; i++) {
      videos.add(Videos.fromMap(data[i]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch Videos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 247, 246, 247),
        foregroundColor: const Color.fromARGB(255, 248, 4, 4),
      ),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          return VideoCart(video: videos[index]);
        },
        separatorBuilder: (__, int index) => SizedBox(height: 40),
        itemCount: videos.length,
      ),
    );
  }
}
