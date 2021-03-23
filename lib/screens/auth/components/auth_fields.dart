import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  const AuthFields({
    Key key,
    this.hint,
    this.controller,
    this.validator,
    this.onSaved,
    // this.hideText,
  }) : super(key: key);

  final String hint;
  final Function validator, onSaved;
  final TextEditingController controller;
  // final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenHeightData(20),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidthData(20)),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            onSaved: onSaved,
            // obscureText: hideText,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
