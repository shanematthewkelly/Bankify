import 'package:Bankify/components/buttons/primary_button.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/models/slides.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:flutter/material.dart';

class SlidesInfo extends StatelessWidget {
  const SlidesInfo({
    Key key,
    this.slide,
    this.index,
  }) : super(key: key);

  final Slides slide;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1,
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidthData(20),
            vertical: 50,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  slide.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'MetroBold',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeightData(12)),
                  child: Text(
                    slide.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          index == 2 ? bottomButton(context) : Container(height: 0),
    );
  }

  Container bottomButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeightData(25),
        left: screenWidthData(15),
        right: screenWidthData(15),
      ),
      child: PrimaryButton(
        buttonText: "Begin the journey",
        onPress: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      ),
    );
  }
}
