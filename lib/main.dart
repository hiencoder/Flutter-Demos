import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Calculator App",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var formKey = GlobalKey<FormState>();
  var currencies = ['VND', 'Dollars', 'Pounds'];
  var currentItemSelected = '';
  final minimumPadding = 5.0;
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var resultDisplay = '';

  @override
  void initState() {
    super.initState();
    this.currentItemSelected = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    //Set text style
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.deepPurple,
          title: Text("Simple Calculator"),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(minimumPadding * 2),
//        margin: EdgeInsets.all(minimumPadding * 2),
            child: ListView(
              //Scroll
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalControlled,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Empty error";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter pricipal e.g. 12000',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiControlled,
                    validator: (String value) {
                      if (value.isEmpty) return 'Empty error';
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of interest',
                        hintText: 'In percent',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termControlled,
                          validator: (String value) {
                            if (value.isEmpty) return 'Empty error';
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in year',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: currentItemSelected,
                          onChanged: (String newSelected) {
                            onDropDownItemSelected(newSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              //debugPrint('Calculator: ');
                              if (formKey.currentState.validate())
                                this.resultDisplay = calculateTotal();
                            });
                          },
                        )),
                        Container(
                          width: minimumPadding * 5,
                        ),
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            //debugPrint('Reset: ');
                            resetInput();
                          },
                        ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: Text(
                    resultDisplay,
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
                  ),
                )
              ],
            ),
          ),
          //resizeToAvoidBottomPadding: false,
        ));
  }

  //Get image
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minimumPadding * 10),
    );
  }

  void onDropDownItemSelected(String newSelected) {
    setState(() {
      this.currentItemSelected = newSelected;
    });
  }

  String calculateTotal() {
    //get input
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double result = principal + (principal * roi * term) / 100;

    return 'Result: $result $currentItemSelected';
  }

  void resetInput() {
    principalControlled.text = "";
    roiControlled.text = "";
    termControlled.text = "";
    resultDisplay = "";
    currentItemSelected = currencies[0];
  }
}
