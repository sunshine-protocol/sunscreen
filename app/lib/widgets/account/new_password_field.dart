import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class NewPasswordFormField extends StatelessWidget {
  final String newPasswordLabel;
  final String passwordLengthError;
  final String confirmPasswordLabel;
  final String passwordMissmatchError;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  NewPasswordFormField({
    @required this.newPasswordLabel,
    @required this.passwordLengthError,
    @required this.confirmPasswordLabel,
    @required this.passwordMissmatchError,
    @required this.passwordController,
    @required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: newPasswordLabel,
          ),
          controller: passwordController,
          validator: (String value) {
            if (value.length < 8) {
              return passwordLengthError;
            }
            return null;
          },
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: confirmPasswordLabel,
          ),
          controller: confirmPasswordController,
          validator: (String value) {
            if (!value.isEmpty && value != passwordController.text) {
              return passwordMissmatchError;
            }
            return null;
          }
        ),
      ],
    );
  }
}
