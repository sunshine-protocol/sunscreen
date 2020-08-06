import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

enum ButtonVariant { primary, secondry, success, danger }

class Button extends StatefulWidget {
  const Button({
    this.onPressed,
    this.text = 'Button',
    this.enabled = true,
    this.textColor = Colors.white,
    this.variant = ButtonVariant.primary,
  });
  @override
  _ButtonState createState() => _ButtonState();
  final String text;
  final FutureOr<void> Function() onPressed;
  final Color textColor;
  final bool enabled;
  final ButtonVariant variant;
}

class _ButtonState extends State<Button> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w.toDouble()),
      child: RaisedButton(
        padding: const EdgeInsets.all(0),
        onPressed: widget.enabled && !_isLoading ? _onPressed : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18.w.toDouble(),
          ),
        ),
        disabledColor: AppColors.disabled,
        color: _variantToColor(widget.variant),
        child: Container(
          height: 55.h.toDouble(),
          child: Center(
            child: AnimatedCrossFade(
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              firstCurve: Curves.ease,
              crossFadeState: _isLoading
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  softWrap: false,
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 18.ssp.toDouble(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              secondChild: const SunshineLoading(
                width: 36,
                height: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _variantToColor(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondry:
        return AppColors.secondry;
      case ButtonVariant.success:
        return AppColors.success;
      case ButtonVariant.danger:
        return AppColors.danger;
      default:
        return AppColors.disabled;
    }
  }

  Future<void> _onPressed() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      _isLoading = false;
    });
  }
}
