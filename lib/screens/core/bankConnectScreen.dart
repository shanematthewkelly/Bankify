import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectBank extends StatefulWidget {
  @override
  _ConnectBankState createState() => _ConnectBankState();
}

class _ConnectBankState extends State<ConnectBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 25,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome, Shane.',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'MetroBold',
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 30),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4)),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.electrical_services,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'L I N K  T H I S  B A N K',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                Switch(
                                  onChanged: (bool value) {},
                                  value: true,
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              "Bank of Ireland",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontFamily: 'avenir'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
