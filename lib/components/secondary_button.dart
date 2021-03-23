import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    this.buttonText,
    this.onPress,
  }) : super(key: key);
  final String buttonText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: screenHeightData(50),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'MetroBold',
                fontSize: screenWidthData(16),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
