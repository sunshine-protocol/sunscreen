import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunshine/sunshine.dart';

class Input extends StatefulWidget {
  const Input({
    this.hintText = 'Input',
    this.maxLines = 1,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.obscureText = false,
    this.readOnly = false,
    this.focusNode,
    this.maxLength,
    this.prefixText,
    this.textInputAction = TextInputAction.unspecified,
    this.textInputType = TextInputType.text,
    this.controller,
    this.errorText,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  });
  @override
  _InputState createState() => _InputState();
  final String hintText;
  final String prefixText;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final int maxLength;
  final TextEditingController controller;
  final String errorText;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onChanged;
  final void Function(String) onFieldSubmitted;
  final void Function() onEditingComplete;
  final void Function(String) onSaved;
  final String Function(String) validator;
  final bool readOnly;
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w.toDouble()),
        child: TextFormField(
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          readOnly: widget.readOnly,
          validator: widget.validator,
          focusNode: widget.focusNode,
          controller: widget.controller,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          inputFormatters: widget.inputFormatters,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,
          maxLength: widget.maxLength,
          enableInteractiveSelection: true,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          style: TextStyle(
            fontSize: 18.ssp.toDouble(),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            errorText: widget.errorText,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.w.toDouble()),
              borderSide: BorderSide(
                color: Colors.black87,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.w.toDouble()),
              borderSide: const BorderSide(
                color: AppColors.secondry,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.w.toDouble()),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            contentPadding: EdgeInsets.all(12.w.toDouble()),
            filled: true,
            prefixText: widget.prefixText,
            hintText: widget.hintText,
          ),
        ),
      );
}
