import 'dart:math';

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Text(
        generateLuckyNumber(),
        textDirection: TextDirection.ltr,
        style: TextStyle(
        color: Colors.white,
        fontSize: 40.0,
        ),
      ),
    ),);
  }

  String generateLuckyNumber() {
    var rd = Random();
    int number = rd.nextInt(100);
    return "Your lucky number is: $number";
  }
}
