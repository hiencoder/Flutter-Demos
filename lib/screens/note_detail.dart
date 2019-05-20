import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/note.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;
  DatabaseHelper databaseHelper = DatabaseHelper();

  NoteDetailState(this.note, this.appBarTitle);

  static var priorities = ['High', 'Low'];
  String currentItemSelected = priorities[0];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    //Fetch data
    titleController.text = note.title;
    contentController.text = note.description;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                backToPreviousScreen();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            top: 15.0,
            right: 10.0,
          ),
          child: ListView(
            children: <Widget>[
              //First element
              ListTile(
                title: DropdownButton(
                  items: priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  style: textStyle,
                  value: 'Low',
                  onChanged: (newValue) {
                    setState(() {
                      debugPrint('Value: $newValue');
                      Text(newValue);
                      updatePriorityAsInt(newValue);
                    });
                  },
                ),
              ),

              //Second element title note
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (title) {
                    debugPrint('Title: $title');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              //Third element content
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: contentController,
                  style: textStyle,
                  onChanged: (content) {
                    debugPrint('Content $content');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Content',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              //Fourth element raised button
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        debugPrint('Save note');
                        saveNote();
                      },
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                    )),

                    Container(
                      width: 5.0,
                    ),
                    //Button delete
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        debugPrint('Delete Note');
                      },
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Delete",
                        textScaleFactor: 1.5,
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () {
        backToPreviousScreen();
      },
    );
  }

  void backToPreviousScreen() {
    Navigator.pop(context, true);
  }

  //Convert string priority -> integer before saving database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //Convert int -> string display dropdown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0]; //'High'
        break;
      case 2:
        priority = priorities[1]; //'Low'
        break;
    }
    return priority;
  }

  //update title
  void updateTitle() {
    note.title = titleController.text;
  }

  //Update content
  void updateDescription() {
    note.description = contentController.text;
  }

  //Save note to database
  void saveNote() async {
    backToPreviousScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      //Update note
      result = await databaseHelper.updateNote(note);
    } else {
      //Insert note
      result = await databaseHelper.insertNote(note);
    }
    if (result != 0) {
      //Save note success
      showAlertDialog('Status', 'Save note successfully');
    } else {
      //Save error
      showAlertDialog('Status', 'Save note error');
    }
  }

  //Delete Note
  void deleteNote() async {
    if (note.id != null) {
      // Note is found
      int result = await databaseHelper.deleteNoteById(note.id);
      if (result != 0) {
        showAlertDialog('Status', 'Delete note is success!');
      } else {
        showAlertDialog('Status', 'Delete note is not success!');
      }
    }

    if (note.id == null) {
      //Note is not found
      showAlertDialog('Status', 'Note empty');
      return;
    }
  }

  void showAlertDialog(String title, String message) {
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}

//https://xuanthulab.net/lap-trinh-bat-dong-bo-asynchronous-trong-dart.html
