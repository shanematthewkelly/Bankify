import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  //Created function and told the navbar to use it
  Function onClickListener;

  //Boolean which determines whether the menu items are set to true or false
  bool navigationalIcons;

  String menuItemText;

  IconData menuItemIcon;

  //Passing in props
  Navbar(
      {@required this.onClickListener,
      @required this.navigationalIcons,
      @required this.menuItemIcon,
      @required this.menuItemText});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //Making a call to the above function
        onTap: widget.onClickListener,
        // If statement which checks whether a menu item is selected or not
        //If it is, it will show the following view
        child: widget.navigationalIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding:
                    EdgeInsets.only(left: 17, right: 17, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      widget.menuItemIcon,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.menuItemText,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
                // else show the user only the icon on the menu if it is not in focus
              )
            : Icon(
                widget.menuItemIcon,
                color: Colors.grey,
              ));
  }
}
