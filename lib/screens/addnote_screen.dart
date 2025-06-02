import 'package:bca_project/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddnoteScreen extends StatefulWidget {
  const AddnoteScreen({super.key});

  @override
  State<AddnoteScreen> createState() => _AddnoteScreenState();
}

class _AddnoteScreenState extends State<AddnoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _showTick = false;

  @override
  void initState() {
    _titleController.addListener(_handleTitleChange);
    super.initState();
  }

  void _handleTitleChange() {
    setState(() {
      _showTick = _titleController.text.trim().isNotEmpty;
    });
  }

  void _saveNote() {
    bool isValid = _globalKey.currentState!.validate();

    if (isValid) {
      Todo todo = Todo(
        id: Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      );
      Navigator.of(context).pop(todo);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          if (_showTick)
            IconButton(onPressed: _saveNote, icon: Icon(Icons.check, size: 35)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _globalKey,
          child: Column(
            spacing: 13,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Title is Null";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Note something down",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 180, 180, 180),
                  ),
                ),
                style: TextStyle(fontSize: 18),
                maxLines: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
