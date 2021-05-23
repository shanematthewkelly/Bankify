import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.transparent;
  final List<Widget> widgets;
  final Text title;
  final Padding profile;
  final bool centered;
  final IconThemeData backArrow;

  const PrimaryAppbar(
      {Key key,
      this.widgets,
      this.title,
      this.profile,
      this.centered,
      this.backArrow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: AppBar(
        iconTheme: backArrow,
        centerTitle: centered,
        title: title,
        leading: profile,
        leadingWidth: screenWidthData(50),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: widgets,
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(screenHeightData(75));
}
