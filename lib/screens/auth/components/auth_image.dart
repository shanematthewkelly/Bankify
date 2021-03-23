import 'package:flutter/material.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        "assets/images/authbg.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
