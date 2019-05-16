// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/note_detail.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_app/model/note.dart';

class NoteList extends StatefulWidget {
  List<Note> notes;
  int count = 0;

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB Click');
          //Navigate to note detail screen
          navigateToDetail('Add Note');
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
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                "Dummy data",
                style: textStyle,
              ),
              subtitle: Text("Dummy Date"),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                debugPrint("Tap title");
                //Navigate to note detail
                navigateToDetail('Edit Note');
              },
            ),
          );
        });
  }

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }

  void deleteNote(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note);
    if(result != 0){
      showSnackBar(context,"Delete success!");
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

  void showSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
