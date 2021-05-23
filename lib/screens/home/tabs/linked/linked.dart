import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/plaid/bankConnectScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Linked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeightData(25),
          ),
          // Dummy Linked #1
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
            padding: EdgeInsets.symmetric(vertical: screenHeightData(20)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    blurRadius: shadowBlur,
                    offset: shadowOffset),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: screenHeightData(45),
                      width: screenWidthData(45),
                      margin: EdgeInsets.only(left: screenWidthData(15)),
                      child: Image.asset("assets/images/currency.png",
                          fit: BoxFit.contain),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Royal Bank of Scotland",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidthData(16),
                                fontFamily: 'MetroBold'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text("L I N K E D",
                                style: TextStyle(
                                  color: Color.fromRGBO(191, 191, 191, 1),
                                  fontSize: screenWidthData(13),
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
          Container(
            height: screenHeightData(25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectBank()),
              );
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
              padding: EdgeInsets.symmetric(vertical: screenHeightData(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: screenWidthData(15)),
                        child: Icon(
                          CupertinoIcons.plus_circle_fill,
                          color: primaryColor,
                          size: 52,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                          "Link Another Bank",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: screenWidthData(18),
                              fontFamily: 'MetroBold'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
