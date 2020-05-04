import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';
import 'secret_form_field.dart';

class PaperBackupForm extends StatefulWidget {
  final EdgeInsets padding;
  final String secretLabel;
  final String secretMissmatchError;
  final String confirmButton;

  PaperBackupForm({
    @required this.padding,
    @required this.secretLabel,
    @required this.secretMissmatchError,
    @required this.confirmButton,
  });

  @override
  State createState() => _PaperBackupFormState();
}

class _PaperBackupFormState extends State<PaperBackupForm> {
  final _secretController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: widget.padding,
                child: BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    final errorText = state is PaperBackup && state.error
                      ? widget.secretMissmatchError
                      : null;
                    return SecretFormField(
                      labelText: widget.secretLabel,
                      errorText: errorText,
                      controller: _secretController,
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context)
                      .add(SetPaperBackup(phrase: _secretController.text));
                  },
                  child: Text(widget.confirmButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
