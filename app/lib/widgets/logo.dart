import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.0),
      child: SizedBox.fromSize(
        child: SvgPicture.asset('assets/logo.svg'),
        size: Size(300.0, 300.0),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 5.0, color: Colors.black),
      ),
    );
  }
}
