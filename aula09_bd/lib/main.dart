import 'package:aula09_bd/view/note_list.dart';
import 'package:aula09_bd/view/notes_local_db_entry.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentPage = 0;

  var _pages = [NoteList(), NotesEntry()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet), label: "View"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "Manage Local"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "Manage Remote"),
          ],
          currentIndex: _currentPage,
          onTap: (int novoIndex) {
            setState(() {
              _currentPage = novoIndex;
            });
          },
          fixedColor: Colors.red,
        ),
        appBar: AppBar(
          title: Text("Minhas Anotações"),
        ),
      ),
    );
  }
}
