import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReusableModal extends StatelessWidget {
  const ReusableModal({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      //Configuring the view port of the device's screen
      height: MediaQuery.of(context).size.height * .45,
      child: Padding(
        padding: EdgeInsets.only(right: 17, top: 17),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    //Modal 'Close' Button
                    Navigator.of(context).pop();
                  },
                  child: Icon(CupertinoIcons.arrow_down_circle_fill,
                      color: Color.fromRGBO(36, 97, 227, .8), size: 30),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 27, top: 30),
                    child: Text(
                        "The details you have entered for your account seem to be incorrect, sorry!",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              padding: EdgeInsets.only(top: 20),
              child: Lottie.asset(
                'assets/lottie/incorrect.json',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
