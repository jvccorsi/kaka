import 'package:aula09_bd/model/note.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List colorLocation = [Colors.red, Colors.blue, Colors.yellow];
  List iconLocation = [
    Icons.error_outline,
    Icons.settings_cell,
    Icons.network_check_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    List<Note> noteList = [];

    Note note1 = Note();
    note1.title = "Primeiro Título";
    Note note2 = Note();
    note2.title = "Primeiro Título";

    noteList.add(note1);
    noteList.add(note2);
    List<int> idList;
    return getNoteListView(noteList, idList);
  }

  ListView getNoteListView(noteList, idList) {
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, position) {
        return Card(
          color: colorLocation[noteList[position].dataLocation],
          elevation: 5,
          child: ListTile(
            leading: Icon(iconLocation[noteList[position].dataLocation]),
            title: Text(noteList[position].title),
            subtitle: Text(noteList[position].description),
            onTap: () {},
            trailing: GestureDetector(onTap: () {}, child: Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}
