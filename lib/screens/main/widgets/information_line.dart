import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class InformationLine extends StatelessWidget {
  const InformationLine({
    @required this.leadingText,
    @required this.secondaryText,
    Key key,
  }) : super(key: key);

  final String leadingText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h.toDouble(),
      color: AppColors.disabled,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h.toDouble(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingText,
            style: TextStyle(
              fontSize: 16.ssp.toDouble(),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            secondaryText,
            style: TextStyle(
              fontSize: 16.ssp.toDouble(),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
