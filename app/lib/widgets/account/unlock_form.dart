import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';

class UnlockForm extends StatefulWidget {
  final EdgeInsets padding;
  final String passwordLabel;
  final String validationError;
  final String unlockButton;

  UnlockForm({
    @required this.padding,
    @required this.passwordLabel,
    @required this.validationError,
    @required this.unlockButton,
  });

  @override
  State createState() => _UnlockFormState();
}

class _UnlockFormState extends State<UnlockForm> {
  final GlobalKey<_UnlockFormState> _key = GlobalKey<_UnlockFormState>();
  final _passwordController = TextEditingController();

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
                    final errorText = state is Locked && state.error
                      ? widget.validationError
                      : null;
                    return TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: widget.passwordLabel,
                        errorText: errorText,
                      ),
                      controller: _passwordController,
                    );
                  }
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context)
                      .add(Unlock(password: _passwordController.text));
                 },
                  child: Text(widget.unlockButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
