import 'package:flutter/material.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/sunshine.dart';
import 'package:provider/provider.dart';

import 'unlock_account_view_model.dart';

class UnlockAccountScreen extends StatefulWidget {
  @override
  _UnlockAccountScreenState createState() => _UnlockAccountScreenState();
}

class _UnlockAccountScreenState extends State<UnlockAccountScreen> {
  TextEditingController _passwordTextController;

  String _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Unlock Account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
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
                  'Please enter your password to unlock your account.',
                  style: TextStyle(
                    fontSize: 16.ssp.toDouble(),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10.h.toDouble()),
              Input(
                hintText: 'Password',
                maxLines: 1,
                errorText: _passwordErrorText,
                controller: _passwordTextController,
                obscureText: true,
                onChanged: (_) {
                  if (_passwordErrorText != null) {
                    setState(() {
                      // clear the error;
                      _passwordErrorText = null;
                    });
                  }
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
              child: BaseWidget<UnlockAccountViewModel>(
                builder: (context, model, _) => model.isBusy
                    ? const CircularProgressIndicator()
                    : Button(
                        text: 'Unlock My Account',
                        onPressed: () {
                          model.unlock(_passwordTextController.value.text);
                          if (model.unlocked) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.main,
                              (_) => false,
                            );
                          } else {
                            setState(() {
                              _passwordErrorText =
                                  'oops! looks like wrong password';
                            });
                          }
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
