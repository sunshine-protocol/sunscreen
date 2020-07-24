import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({String title, double elevation = 0})
      : _title = title,
        _elevation = elevation;

  final String _title;
  final double _elevation;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: _elevation,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          ExtendedNavigator.root.pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
