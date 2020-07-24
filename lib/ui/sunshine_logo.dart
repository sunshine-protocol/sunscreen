import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SunshineLogo extends StatelessWidget {
  const SunshineLogo({double width = 100, double height = 100})
      : _height = height,
        _width = width;
  final double _width;
  final double _height;
  @override
  Widget build(BuildContext context) {
    return WebsafeSvg.asset(
      'assets/svg/sun.svg',
      height: _height,
      width: _width,
      fit: BoxFit.fill,
    );
  }
}
