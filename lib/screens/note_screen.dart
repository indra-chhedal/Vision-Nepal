import 'package:bca_project/models/todo.dart';
import 'package:bca_project/screens/add_todo_screen.dart';
import 'package:bca_project/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Todo> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.note)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          children: [
            Text("Total Number of list is (${todos.length})"),
            SizedBox(height: 10),
            Expanded(
              child:
                  todos.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('images/empty.svg', width: 200),
                            Text(
                              AppLocalizations.of(context)!.empty,
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          Todo todo = todos[index];

                          return ListTile(
                            onLongPress: () {
                              //list item ma long press garda bottomsheet khulna banako ho
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text("Delete"),
                                          onTap: () {
                                            //show dialog for dialog box for alert dialog
                                            Navigator.of(context).pop();
                                            setState(() {
                                              todos.removeAt(index);
                                            });
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text("Edit"),
                                          onTap: () async {
                                            Navigator.of(context).pop();

                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => EditScreen(
                                                      todoItem: todo,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            title: Text(todo.title),
                            subtitle: Text(todo.description),
                            trailing: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                //yasma chai todos ko index lai replace garxa todo la ani complete xa vani uncomplete garxa tougle garxa
                                setState(() {
                                  //todo lai rerender garna parxa setstate garyara
                                  todos[index] = todo.copyWith(
                                    isCompleted: !todo.isCompleted,
                                  );
                                });
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo? todo = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => TodoAdd()));
          if (todo != null) {
            setState(() {
              todos.add(todo);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
