import 'package:Bankify/screens/core/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BankSuccessful extends StatefulWidget {
  @override
  _BankSuccessfulState createState() => _BankSuccessfulState();
}

class _BankSuccessfulState extends State<BankSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 2.2,
                child: Lottie.asset('assets/lottie/bankConnected.json',
                    fit: BoxFit.contain, height: 150),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Account Linked Succesfully.',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'MetroBold',
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()),
              (Route<dynamic> route) => false);
        },
        child: Container(
          margin: EdgeInsets.all(15),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 97, 227, .8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .3),
                  blurRadius: 25.0,
                  offset: Offset(0, 7))
            ],
          ),
          child: Center(
            child: Text(
              "C O N T I N U E",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
