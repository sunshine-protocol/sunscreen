import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';
import 'new_password_field.dart';

class CreateAccountForm extends StatefulWidget {
  final EdgeInsets padding;
  final String newPasswordLabel;
  final String passwordLengthError;
  final String confirmPasswordLabel;
  final String passwordMissmatchError;
  final String importButton;
  final String createButton;

  CreateAccountForm({
    @required this.padding,
    @required this.newPasswordLabel,
    @required this.passwordLengthError,
    @required this.confirmPasswordLabel,
    @required this.passwordMissmatchError,
    @required this.importButton,
    @required this.createButton,
  });

  @override
  State createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        autovalidate: true,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: widget.padding,
                child: NewPasswordFormField(
                  newPasswordLabel: widget.newPasswordLabel,
                  passwordLengthError: widget.passwordLengthError,
                  confirmPasswordLabel: widget.confirmPasswordLabel,
                  passwordMissmatchError: widget.passwordMissmatchError,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/restore_account');
                  },
                  child: Text(widget.importButton),
                ),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context)
                      .add(Generate(password: _passwordController.text));
                  },
                  child: Text(widget.createButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
