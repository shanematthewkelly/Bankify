import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.transparent;
  final List<Widget> widgets;
  final Text title;
  final Padding profile;
  final PreferredSize bottomTabs;

  const TabsAppbar(
      {Key key, this.widgets, this.title, this.profile, this.bottomTabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 12),
        child: AppBar(
          title: title,
          leading: profile,
          leadingWidth: screenWidthData(50),
          backgroundColor: backgroundColor,
          elevation: 0,
          actions: widgets,
          bottom: bottomTabs,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(screenHeightData(140));
}
