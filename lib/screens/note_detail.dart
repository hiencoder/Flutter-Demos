import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;

  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  String appBarTitle;

  NoteDetailState(this.appBarTitle);

  static var priority = ['High', 'medium', 'Low'];
  String currentItemSelected = priority[0];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
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
                  items: priority.map((String dropDownStringItem) {
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
    Navigator.pop(context);
  }
}

//https://xuanthulab.net/lap-trinh-bat-dong-bo-asynchronous-trong-dart.html
