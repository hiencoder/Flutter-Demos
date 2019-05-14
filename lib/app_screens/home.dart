import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.center,
            //Cho thành phần trong container nằm vị trí so vs màn hình
            color: Colors.deepPurple,
//      width: 200.0,
//      height: 100.0,
            //margin: EdgeInsets.only(left: 35.0, top: 50.0),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Row 1",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 30.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "Đây là nội dung để test hahahah",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Row2",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 30.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "Đây là nội dung để test ahaahah ",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )),
                  ],
                ),
                VenomImageAsset(),
                FlightBookButton()
              ],
            )

            //Sắp xếp widget theo chiều  ngang(hàng)
            /*Row(
        children: <Widget>[
          Expanded(
              child: Text(
            "Test1",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 35.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          )),
          Expanded(
              child: Text(
            "Đây là nội dung để test ahaahah ahahhaha hahahah",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 35.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          )),
        ],
      ),*/
            /*Style*/
            /*child: Text(
        "Flight",
        textDirection: TextDirection.ltr,
        style: TextStyle(decoration: TextDecoration.none, fontSize: 75.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: Colors.white),
      ),*/
            ));
  }
}

class VenomImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/venom.jpg');
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 250.0,
    );
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: image,
    );
  }
}

class FlightBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
          color: Colors.lightBlue,
          child: Text(
            "Click me",
            style: TextStyle(
                color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
            textAlign: TextAlign.center,
          ),
          elevation: 6.0,
          onPressed: () {
            //action
            clickMe(context);
          }),
    );
  }

  void clickMe(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Title Dialog"),
      content: Text("Click data success!"),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Ok",
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
          ],
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
