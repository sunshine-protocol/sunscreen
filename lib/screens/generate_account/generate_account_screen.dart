import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class GenerateAccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Generate Account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: _buildForm(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: 'Proceed to backup phrase',
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    Navigator.of(context).pushNamed(Routes.accountPharse);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    final context = _formKey.currentContext;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 13.h.toDouble()),
        Text(
          'Account details',
          style: TextStyle(fontSize: 36.ssp.toDouble()),
        ),
        SizedBox(height: 42.h.toDouble()),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Input(
                hintText: 'First Name',
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_lastNameNode);
                },
                focusNode: _firstNameNode,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16.h.toDouble()),
              Input(
                hintText: 'Last Name',
                focusNode: _lastNameNode,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16.h.toDouble()),
              Input(
                hintText: 'Password',
                focusNode: _passwordNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_confirmPasswordNode);
                },
                obscureText: true,
              ),
              SizedBox(height: 16.h.toDouble()),
              Input(
                hintText: 'Confirm Password',
                focusNode: _confirmPasswordNode,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                obscureText: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
