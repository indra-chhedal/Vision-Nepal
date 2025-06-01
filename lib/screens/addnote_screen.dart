import 'package:flutter/material.dart';

class AddnoteScreen extends StatefulWidget {
  const AddnoteScreen({super.key});

  @override
  State<AddnoteScreen> createState() => _AddnoteScreenState();
}

class _AddnoteScreenState extends State<AddnoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 13,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Note Something Down",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 180, 180, 180),
                ),
              ),
              maxLines: 40,
            ),
          ],
        ),
      ),
    );
  }
}
