import 'dart:async';
import 'dart:io';

import 'package:aula09_bd/model/note.dart';
import 'package:aula09_bd/view/note_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;

  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'node.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return notesDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable ($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT) ");
  }

  /* INSERT */
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    int result = await db.insert(noteTable, note.toMap());
    notify();

    return result;
  }

  //QUERY (SELECT): retorna tudo que tem no BD.

  getNoteList() async {
    Database db = await this.database;
    var noteMapList = await db.rawQuery('SELECT * FROM $noteTable');
    List<Note> noteList = [];
    List<int> idList = [];
    for (int i = 0; i < noteMapList.length; i++) {
      Note note = Note.fromMap(noteMapList[i]);
      note.dataLocation = 1;
      noteList.add(note);
      idList.add(noteMapList[i]['id']);
    }
    return [noteList, idList];
  }

//QUERY (UPDATE):

  Future<int> updateNote(int noteId, Note note) async {
    Database db = await this.database;
    var result = await db.update(
      noteTable,
      note.toMap(),
      where: '$colID = ?',
      whereArgs: [noteId],
    );
    notify();
    return result;
  }

//QUERY (DELETE):
  Future<int> deleteNote(int noteId) async {
    Database db = await this.database;
    int result =
        await db.rawDelete("DELETE FROM $noteTable WHERE  $colID= $noteId");
    notify();
    return result;
  }

  /* 
   STREAM

  */
//NOTIFICA AS COISAS PARA O USUÁRIO.
  notify() async {
    if (_controller != null) {
      var response = await getNoteList();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}
