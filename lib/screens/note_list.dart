// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/note_detail.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_app/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  List<Note> notes;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if (notes == null) {
      notes = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB Click');
          //Navigate to note detail screen
          navigateToDetail(Note('', '', '', 2), 'Add Note');
        },
        tooltip: 'Add note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          //Fetch data item position
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.notes[position].priority),
                child: getPriorityIcon(this.notes[position].priority),
              ),
              title: Text(
                this.notes[position].title,
                style: textStyle,
              ),
              subtitle: Text(
                this.notes[position].date,
                style: textStyle,
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  deleteNote(context, this.notes[position]);
                },
              ),
              onTap: () {
                debugPrint("Tap title");
                //Navigate to note detail
                navigateToDetail(this.notes[position], 'Edit Note');
              },
            ),
          );
        });
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));
    if(result){
      updateListView();
    }
  }

  //Delete note
  void deleteNote(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note);
    if (result != 0) {
      showSnackBar(context, "Delete success!");
      updateListView();
    }
  }

//https://android.jlelse.eu/recyclerview-adapter-a-piece-of-cake-with-the-generic-adapter-766cedffd81
  //Return priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
        break;
    }
  }

  //Return priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
        break;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.notes = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

//https://github.com/nb312?tab=repositories
