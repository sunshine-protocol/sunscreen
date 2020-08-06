import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    String title,
    double elevation = 0,
    Widget leading,
    List<Widget> actions,
  })  : _title = title,
        _elevation = elevation,
        _leading = leading,
        _actions = actions;

  final String _title;
  final double _elevation;
  final Widget _leading;
  final List<Widget> _actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.mainBackground,
      brightness: Brightness.dark,
      elevation: _elevation,
      actions: _actions,
      leading: _leading ??
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              ExtendedNavigator.root.pop();
            },
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
