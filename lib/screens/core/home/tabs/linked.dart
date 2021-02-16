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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Dummy Linked #1
            Container(
              width: MediaQuery.of(context).size.height / 1,
              margin: EdgeInsets.only(left: 15, right: 15, top: 0),
              padding: EdgeInsets.only(top: 18, bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(left: 14),
                        child: Image.asset("assets/images/currency.png",
                            fit: BoxFit.contain),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Royal Bank of Scotland",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'MetroBold'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("L I N K E D",
                                  style: TextStyle(
                                    color: Color.fromRGBO(191, 191, 191, 1),
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Dummy Linked #2
            Container(
              width: MediaQuery.of(context).size.height / 1,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              padding: EdgeInsets.only(top: 18, bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(left: 14),
                        child: Image.asset("assets/images/irish.png",
                            fit: BoxFit.contain),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Bank of Ireland",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'MetroBold'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("L I N K E D",
                                  style: TextStyle(
                                    color: Color.fromRGBO(191, 191, 191, 1),
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Dummy Linked #3
            Container(
              width: MediaQuery.of(context).size.height / 1,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              padding: EdgeInsets.only(top: 18, bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(left: 14),
                        child: Image.asset("assets/images/germany.jpg",
                            fit: BoxFit.contain),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Deutsche Bank",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'MetroBold'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("L I N K E D",
                                  style: TextStyle(
                                    color: Color.fromRGBO(191, 191, 191, 1),
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
