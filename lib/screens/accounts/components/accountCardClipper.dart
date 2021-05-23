import 'package:flutter/cupertino.dart';

class AccountCardClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = new Path();

    path.moveTo(size.width / 1.4, 0);
    path.lineTo(size.width / 1.8, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
