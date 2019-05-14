import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Stateful App Example",
    home: FavoriteCity(),
  ));
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";

  //Mảng string cho dropdownlist
  var currencies = ['Dollar', 'VND', 'Euro'];

  //String đc chon
  var currentItemSelected = 'Dollar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful App Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
              items: currencies.map((String dropdownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropdownStringItem,
                  child: Text(dropdownStringItem),
                );
              }).toList(),
              onChanged: (String value) {
                _onDropDownItemSelected(value);
              },
              value: currentItemSelected,
            ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "City: $nameCity",
                  style: TextStyle(fontSize: 20.0),
                ))
          ],
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }
}
