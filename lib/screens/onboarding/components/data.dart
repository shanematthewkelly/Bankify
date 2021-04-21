import 'package:flutter/material.dart';

import '../../../configs/screen_sizing.dart';

class OnBoardingData extends StatelessWidget {
  const OnBoardingData({
    Key key,
    this.heading,
    this.description,
    this.image,
  }) : super(key: key);
  final String heading, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          image,
          height: screenHeightData(340),
          width: screenWidthData(320),
          fit: BoxFit.contain,
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidthData(20)),
          child: Text(
            heading,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: screenWidthData(35),
                color: Colors.black,
                fontFamily: 'VarelaRound',
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(height: screenHeightData(20)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidthData(20)),
          child: Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Montserrat-Secondary',
                fontSize: screenWidthData(15)),
          ),
        ),
        Container(
          height: screenHeightData(30),
        )
      ],
    );
  }
}
