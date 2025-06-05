import 'package:bca_project/models/todo.dart';
import 'package:bca_project/screens/addnote_screen.dart';
import 'package:bca_project/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

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

                          return Card(
                            elevation: 1,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Dismissible(
                              key: Key(todos.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                color: Colors.red,
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text("Delete Note?"),
                                        content: Text(
                                          "Are you Sure you want to delete this note?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.of(
                                                  context,
                                                ).pop(false),
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.of(
                                                  context,
                                                ).pop(true),
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  todos.removeAt(index);
                                });
                              },
                              child: ListTile(
                                // onLongPress: () {
                                //   //list item ma long press garda bottomsheet khulna banako ho
                                //   showModalBottomSheet(
                                //     context: context,
                                //     builder: (context) {
                                //       return Padding(
                                //         padding: EdgeInsets.symmetric(
                                //           vertical: 30,
                                //         ),
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             ListTile(
                                //               leading: Icon(Icons.delete),
                                //               title: Text("Delete"),
                                //               onTap: () {
                                //                 //show dialog for dialog box for alert dialog
                                //                 Navigator.of(context).pop();
                                //                 setState(() {
                                //                   todos.removeAt(index);
                                //                 });
                                //               },
                                //             ),
                                //             ListTile(
                                //               leading: Icon(Icons.edit),
                                //               title: Text("Edit"),
                                //               onTap: () async {
                                //                 Navigator.of(context).pop();

                                //                 await Navigator.of(context).push(
                                //                   MaterialPageRoute(
                                //                     builder:
                                //                         (context) => EditScreen(
                                //                           todoItem: todo,
                                //                         ),
                                //                   ),
                                //                 );
                                //               },
                                //             ),
                                //           ],
                                //         ),
                                //       );
                                //     },
                                //   );
                                // },
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              EditScreen(todoItem: todo),
                                    ),
                                  );
                                  
                                },

                                title: Text(
                                  
                                  todo.title,
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                      221,
                                      39,
                                      38,
                                      38,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  todo.description,
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
          ).push(MaterialPageRoute(builder: (context) => AddnoteScreen()));
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
