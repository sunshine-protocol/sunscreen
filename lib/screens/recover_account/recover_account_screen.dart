import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/sunshine.dart';

import 'recover_account_view_model.dart';

class RecoverAccountScreen extends StatefulWidget {
  @override
  _RecoverAccountScreenState createState() => _RecoverAccountScreenState();
}

class _RecoverAccountScreenState extends State<RecoverAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwrodNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Recover Account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BaseWidget<RecoverAccountViewModel>(
        model: RecoverAccountViewModel(accountService: context.watch()),
        builder: (context, model, _) => Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w.toDouble(),
                      vertical: 16.h.toDouble(),
                    ),
                    child: Text(
                      'Please enter your backup phrase'
                      ' to recover your account.',
                      style: TextStyle(
                        fontSize: 16.ssp.toDouble(),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 10.h.toDouble()),
                  Input(
                    hintText: 'walrus thought faculty portion'
                        'music ginger slush awful give mechanic',
                    maxLines: 3,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwrodNode);
                    },
                    onFieldSubmitted: (v) {
                      model.setPharse(v);
                    },
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Hey!!';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10.h.toDouble()),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w.toDouble(),
                      vertical: 16.h.toDouble(),
                    ),
                    child: Text(
                      'also, to keep your account safe, enter a password.',
                      style: TextStyle(
                        fontSize: 16.ssp.toDouble(),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Input(
                    hintText: 'Password',
                    obscureText: true,
                    focusNode: _passwrodNode,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'enter the password please!';
                      } else if (v.length < 8) {
                        return 'password must be at least 8 characters long';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (v) {
                      model.setPassword(v);
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  text: 'Recover My Account',
                  onPressed: () {
                    final form = _formKey.currentState..save();
                    if (form.validate()) {
                      model.recover();
                      if (model.recovered) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.main,
                          (_) => false,
                        );
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Recover Failed!'),
                          backgroundColor: Colors.redAccent,
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
