// TODO Implement this library.
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(context),
    );
  }

  ListView getNoteListView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count, itemBuilder: (BuildContext context, int position) {
          
    });
  }
}
