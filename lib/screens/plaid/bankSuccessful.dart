import 'package:Bankify/components/buttons/primary_button.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/home/home.dart';
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
                    fit: BoxFit.contain, height: 200),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Account Linked Successfully.',
                    style: TextStyle(
                        fontSize: screenWidthData(22),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidthData(20),
          vertical: screenHeightData(15),
        ),
        child: PrimaryButton(
          buttonText: "Continue",
          onPress: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              (Route<dynamic> route) => false),
        ),
      ),
    );
  }
}
