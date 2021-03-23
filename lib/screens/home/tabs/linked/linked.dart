import 'package:Bankify/configs/screen_sizing.dart';
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
          // Dummy Linked #2
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
            padding: EdgeInsets.symmetric(vertical: screenHeightData(20)),
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
                      height: screenHeightData(45),
                      width: screenWidthData(45),
                      margin: EdgeInsets.only(left: screenWidthData(15)),
                      child: Image.asset("assets/images/irish.png",
                          fit: BoxFit.contain),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Bank of Ireland",
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
          // Dummy Linked #3
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
            padding: EdgeInsets.symmetric(vertical: screenHeightData(20)),
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
                      height: screenHeightData(45),
                      width: screenWidthData(45),
                      margin: EdgeInsets.only(left: screenWidthData(15)),
                      child: Image.asset("assets/images/germany.jpg",
                          fit: BoxFit.contain),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Deutsche Bank",
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
        ],
      ),
    );
  }
}
