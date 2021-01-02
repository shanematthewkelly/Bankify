import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Linked extends StatefulWidget {
  @override
  _LinkedState createState() => _LinkedState();
}

class _LinkedState extends State<Linked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.power),
              Text("L I N K E D"),
            ],
          ),
        ),
      ),
    );
  }
}
