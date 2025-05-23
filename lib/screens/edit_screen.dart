import 'package:bca_project/models/todo.dart';
import 'package:flutter/material.dart';


class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.todoItem});

  final Todo todoItem;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController titleControler;
  late TextEditingController descriptionControler;

  @override
  void initState() {
    //init state ma chai previous value ni same rahanxa pahila ko filed ma that means pahila ko value initialized vayara basyako hunxa
    titleControler = TextEditingController(text: widget.todoItem.title);
    descriptionControler = TextEditingController(
      text: widget.todoItem.description,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 242, 242),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(115, 125, 124, 124),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Edit Item", style: TextStyle(fontSize: 24)),

                    Column(
                      children: [
                        TextFormField(
                          controller: titleControler,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 255, 254, 254),
                            // hintText: "Enter title",
                            labelText: "Enter Title",
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Title is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        TextFormField(
                          maxLines: 3,
                          controller: descriptionControler,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 254, 254, 254),
                            // hintText: "Enter Description",
                            labelText: "Description",
                            alignLabelWithHint: true,

                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Title is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        spacing: 20,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bool isValid = _formKey.currentState!.validate();

                              if (isValid) {
                                Todo todo = Todo(
                                  title: titleControler.text,
                                  description: descriptionControler.text,
                                  isCompleted: false,
                                );
                                
                                Navigator.of(context).pop(todo);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(255, 211, 210, 209),
                              ),
                            ),
                            child: Text(
                              "Edit Item",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(255, 211, 210, 209),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
