import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch Videos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 247, 246, 247),
        foregroundColor: const Color.fromARGB(255, 248, 4, 4),
      ),
      body: Column(),
    );
  }
}
