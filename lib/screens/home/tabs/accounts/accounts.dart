import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/accounts/accountsDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeightData(25),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
            padding: EdgeInsets.only(top: screenHeightData(25)),
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
                Container(
                  height: screenHeightData(70),
                  width: screenWidthData(70),
                  margin: EdgeInsets.only(left: screenWidthData(15)),
                  child: Image.asset("assets/images/accounts-icon.png",
                      fit: BoxFit.contain),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: screenHeightData(30)),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(left: screenWidthData(18)),
                              child: Text(
                                "Get More\nFrom Your Accounts.",
                                style: TextStyle(
                                    fontSize: screenWidthData(28),
                                    fontFamily: 'MetroBold'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenWidthData(15),
                                right: screenWidthData(15),
                                top: screenHeightData(10),
                              ),
                              child: Text(
                                "Dive in and explore more about our account types. Your accounts are private and safe with us.",
                                style: TextStyle(
                                    fontSize: screenWidthData(15),
                                    color: Color.fromRGBO(191, 191, 191, 1)),
                              ),
                            ),
                            Container(
                              height: screenHeightData(30),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              height: screenHeightData(65),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(15)),
                                color: Color.fromRGBO(26, 68, 237, 1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountsDetail()),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidthData(20)),
                                      height: screenHeightData(40),
                                      width: screenWidthData(180),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Get Started.",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  26, 68, 237, 1),
                                              fontSize: screenWidthData(16),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
