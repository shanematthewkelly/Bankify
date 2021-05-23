import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarRightIcon extends StatelessWidget {
  const AppbarRightIcon({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () => onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
