import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  const Recommended({
    Key key,
    this.images,
    this.title,
    this.desc,
    this.pressedRecommended,
  }) : super(key: key);
  final String images, title, desc;
  final Function pressedRecommended;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressedRecommended,
      child: Container(
        width: screenWidthData(270),
        margin: EdgeInsets.only(
          bottom: screenHeightData(60),
          top: screenHeightData(20),
          left: screenWidthData(15),
          right: screenWidthData(15),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeightData(160),
              width: screenWidthData(270),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: new AssetImage(images),
                  )),
            ),
            Container(
              width: screenWidthData(270),
              padding: EdgeInsets.only(
                  top: screenHeightData(20),
                  bottom: screenHeightData(20),
                  left: screenWidthData(12),
                  right: screenWidthData(12)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 25,
                      color: Colors.grey[300],
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                      fontFamily: 'MetroBold',
                      fontSize: screenWidthData(19),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      "$desc".toUpperCase(),
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidthData(12),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
