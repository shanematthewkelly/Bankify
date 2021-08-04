import 'package:flutter/material.dart';

class ScreenSizing {
  static MediaQueryData _mediaQueryData = _mediaQueryData;
  static double screenWidth = screenWidth;
  static double screenHeight = screenHeight;
  static Orientation orientation = orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Height per screen size
double screenHeightData(double height) {
  double screenHeight = ScreenSizing.screenHeight;

  return (height / 896.0) * screenHeight;
}

// Width per screen size
double screenWidthData(double width) {
  double screenWidth = ScreenSizing.screenWidth;

  return (width / 414.0) * screenWidth;
}
