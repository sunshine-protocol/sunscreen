import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

enum ButtonVariant { normal, thin, success }

class Button extends StatefulWidget {
  const Button({
    this.onPressed,
    this.text = 'Button',
    this.enabled = true,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.primary,
    this.variant = ButtonVariant.normal,
  });
  @override
  _ButtonState createState() => _ButtonState();
  final String text;
  final void Function() onPressed;
  final Color textColor;
  final Color backgroundColor;
  final bool enabled;
  final ButtonVariant variant;
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w.toDouble()),
      child: RaisedButton(
        padding: const EdgeInsets.all(0),
        onPressed: widget.enabled ? widget.onPressed : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w.toDouble()),
          side: BorderSide(
              color: widget.variant == ButtonVariant.success
                  ? Colors.greenAccent.withOpacity(0.5)
                  : AppColors.primary.withOpacity(0.5),
              width: 3),
        ),
        disabledColor: AppColors.disabled,
        child: Ink(
          height: widget.variant == ButtonVariant.thin
              ? 39.h.toDouble()
              : 59.h.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w.toDouble()),
            gradient: LinearGradient(
              colors: widget.variant == ButtonVariant.success
                  ? const [Color(0xFF29C5A9), Color(0xFF35CB95)]
                  : const [Color(0xFF69A5FF), Color(0xFF8995FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              maxLines: 1,
              softWrap: false,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                color: widget.onPressed == null || !widget.enabled
                    ? Colors.black
                    : widget.textColor,
                fontSize: 16.ssp.toDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
