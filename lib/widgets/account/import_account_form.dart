import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';
import 'new_password_field.dart';
import 'secret_form_field.dart';

class ImportAccountForm extends StatefulWidget {
  final EdgeInsets padding;
  final String secretPhraseLabel;
  final String newPasswordLabel;
  final String passwordLengthError;
  final String confirmPasswordLabel;
  final String passwordMissmatchError;
  final String importButton;

  ImportAccountForm({
    @required this.padding,
    @required this.secretPhraseLabel,
    @required this.newPasswordLabel,
    @required this.passwordLengthError,
    @required this.confirmPasswordLabel,
    @required this.passwordMissmatchError,
    @required this.importButton,
  });

  @override
  State createState() => _ImportAccountFormState();
}

class _ImportAccountFormState extends State<ImportAccountForm> {
  final _secretController = TextEditingController();
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
                child: BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    print(state);
                    final errorText = state is ImportFailed
                      ? state.error
                      : null;
                    return SecretFormField(
                      labelText: widget.secretPhraseLabel,
                      errorText: errorText,
                      controller: _secretController,
                    );
                  },
                ),
              ),
            ),
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
                RaisedButton(
                  onPressed: () {
                    final phrase = _secretController.text;
                    final password = _passwordController.text;
                    BlocProvider.of<AccountBloc>(context)
                      .add(Import(phrase: phrase, password: password));
                  },
                  child: Text(widget.importButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
