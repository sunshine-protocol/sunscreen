import 'package:flutter/material.dart';

class Styles {
  static TextStyle title = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
  );

  static TextStyle message = TextStyle(
    fontSize: 36,
  );

  static TextStyle button = TextStyle(
    fontSize: 24,
  );

  static EdgeInsets containerPadding = EdgeInsets.all(16.0);

  static ButtonThemeData buttonTheme = ButtonThemeData(
    padding: EdgeInsets.symmetric(horizontal: 32.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    buttonColor: Colors.black,
    textTheme: ButtonTextTheme.primary,
  );

  static ThemeData theme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
    ),
    buttonTheme: buttonTheme,
  );
}
