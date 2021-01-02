import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          margin: EdgeInsets.only(left: 15, right: 15, top: 24, bottom: 24),
          padding: EdgeInsets.only(top: 30, left: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 0.2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      "€250",
                      style: TextStyle(fontSize: 30, fontFamily: 'MetroBold'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        size: 22,
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 4),
                child: Text(
                  "A V A I L A B L E",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
