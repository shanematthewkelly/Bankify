import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllAccounts extends StatefulWidget {
  @override
  _AllAccountsState createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.group),
              Text("A C C O U N T S"),
            ],
          ),
        ),
      ),
    );
  }
}
