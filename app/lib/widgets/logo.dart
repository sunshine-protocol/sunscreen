import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(36.0),
        child: SvgPicture.asset('assets/logo.svg'),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 5.0, color: Colors.black),
        ),
      ),
    );
  }
}
