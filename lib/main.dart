import 'package:flutter/material.dart';
import './app_screens/home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exploring UI widgets",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Long List"),
        ),
        body: getListViewLongList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("Fab click");
          },
          child: Icon(Icons.add),
          tooltip: "Add One More Item",
        ),

        //Basic listView
        /*appBar: AppBar(
          title: Text("Basic ListView"),
        ),
        body: getListView(),*/

        //Long list
      )
      //Home(),
      ));
}

Widget getListView() {
  var lv = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.landscape),
        title: Text("Landscape"),
        subtitle: Text("Beautiful View!"),
        trailing: Icon(Icons.wb_sunny),
        onTap: () {
          debugPrint("LandScape tap");
        },
      ),
      ListTile(
        leading: Icon(Icons.laptop_mac),
        title: Text("Macbook"),
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text("Phone"),
      ),
      Text("Yet another element in Light"),
      Container(
        color: Colors.red,
        height: 50.0,
      )
    ],
  );
  return lv;
}

List<String> getListElements() {
  var items = List<String>.generate(1000, (counter) => "Item $counter");
  return items;
}

Widget getListViewLongList() {
  var listItem = getListElements();
  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(Icons.arrow_right),
      title: Text(listItem[index]),
      onTap: () {
        //debugPrint('${listItem[index]} was tapped!');
        showSnackBar(context, '${listItem[index]} was tapped');
      },
    );
  });

  return listView;
}

void showSnackBar(BuildContext context, String content) {
  var snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          debugPrint("UNDO click");
        },
      ));
  Scaffold.of(context).showSnackBar(snackBar);
}
