import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class BlankScreen extends StatefulWidget {
  @override
  _BlankScreenState createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: true,
    );
    return Scaffold(
      body: Center(
        child: Button(
          text: 'Generate Account',
          variant: ButtonVariant.success,
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
        ),
      ),
    );
  }
}
