import 'package:flutter/material.dart';
import 'package:flutter_app/screens/note_list.dart';
import 'package:flutter_app/screens/note_detail.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Notes",
    home: NoteList(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}
