import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkedFragement extends StatefulWidget {
  @override
  _LinkedFragementState createState() => _LinkedFragementState();
}

class _LinkedFragementState extends State<LinkedFragement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("LINKED FRAGMENT",
                  style: TextStyle(fontSize: 17, fontFamily: 'MetroBold')),
            ],
          ),
        ),
      ),
    );
  }
}
