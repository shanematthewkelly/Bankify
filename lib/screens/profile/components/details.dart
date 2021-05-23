import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    Key key,
    @required this.icon,
    @required this.profileInfo,
    this.onPress,
  }) : super(key: key);
  final IconData icon;
  final String profileInfo;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: screenHeightData(25)),
        padding: EdgeInsets.symmetric(vertical: screenHeightData(14)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlur,
              offset: shadowOffset,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: secondaryColor,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: screenWidthData(26),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profileInfo,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidthData(16),
                            fontFamily: 'MetroBold'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
