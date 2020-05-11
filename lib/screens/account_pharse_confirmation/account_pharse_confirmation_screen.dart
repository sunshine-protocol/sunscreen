import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'account_pharse_confirmation_view_model.dart';

class AccountPharseConfirmationScreen extends StatefulWidget {
  const AccountPharseConfirmationScreen({
    Key key,
    this.accountBackup,
  }) : super(key: key);

  final AccountBackup accountBackup;

  @override
  _AccountPharseConfirmationScreenState createState() =>
      _AccountPharseConfirmationScreenState();
}

class _AccountPharseConfirmationScreenState
    extends State<AccountPharseConfirmationScreen> {
  final _pharseTextController = TextEditingController();
  String _errorText;
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountPharseConfirmationViewModel>(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Account Phrase',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      builder: (context, model, child) {
        return Scaffold(
          // ignore: avoid_as
          appBar: child as PreferredSizeWidget,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w.toDouble(),
                      vertical: 16.h.toDouble(),
                    ),
                    child: Text(
                      'Please enter your backup phrase to confirm.',
                      style: TextStyle(
                        fontSize: 16.ssp.toDouble(),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 10.h.toDouble()),
                  Input(
                    hintText: widget.accountBackup.phrase,
                    maxLines: 3,
                    controller: _pharseTextController,
                    maxLength: widget.accountBackup.phrase.length,
                    enableSuggestions: true,
                    autocorrect: true,
                    errorText: _errorText,
                    onChanged: (_) {
                      _errorText = null;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 32.h.toDouble()),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    text: 'Confirm and Finish',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      model.backup(
                        widget.accountBackup,
                        _pharseTextController.value.text,
                      );
                      if (model.backedUp) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.main,
                          (_) => false,
                        );
                      } else {
                        setState(() {
                          _errorText = 'please enter the correct phrase!';
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
