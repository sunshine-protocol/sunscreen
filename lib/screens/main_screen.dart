import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MainScreenAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [],
      ),
    );
  }
}

class _MainScreenAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _LogoIcon(),
          GestureDetector(
            child: const _ProfileIcon(),
            onTap: () {
              ExtendedNavigator.root.pushAccountScreen();
            },
          )
        ],
      ),
    );
  }
}

class _LogoIcon extends StatelessWidget {
  const _LogoIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w.toDouble(),
        vertical: 35.h.toDouble(),
      ),
      child: const SunshineLogo(
        height: 42,
        width: 42,
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w.toDouble(),
        vertical: 35.h.toDouble(),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.black,
            ),
          ),
          borderRadius: BorderRadius.circular(
            42.w.toDouble(),
          ),
        ),
        child: Icon(
          Icons.person,
          size: 42,
          color: Colors.black,
        ),
      ),
    );
  }
}
