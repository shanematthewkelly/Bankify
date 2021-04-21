import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/models/slides.dart';
import 'package:flutter/material.dart';

class SlidesInfo extends StatelessWidget {
  const SlidesInfo({
    Key key,
    this.slide,
  }) : super(key: key);

  final Slides slide;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
