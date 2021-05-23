import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  const AuthFields({
    Key key,
    this.hint,
    this.controller,
    this.validator,
    this.onSaved,
    this.hideText,
  }) : super(key: key);

  final String hint;
  final Function validator, onSaved;
  final TextEditingController controller;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenHeightData(20),
        ),
        Container(
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: hideText == true ? hideText : false,
            onSaved: onSaved,
            style: TextStyle(
              color: Colors.black54,
              fontSize: screenWidthData(16),
              fontWeight: FontWeight.bold,
              fontFamily: 'MetroBold',
            ),
            decoration: InputDecoration(
              hintText: hint,
              focusedBorder: UnderlineInputBorder(
                borderSide: new BorderSide(color: primaryColor),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.red),
              ),
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: screenWidthData(16),
                fontWeight: FontWeight.bold,
                fontFamily: 'MetroBold',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
