import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class GenerateAccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 13.h.toDouble()),
            Text(
              'Account details',
              style: TextStyle(fontSize: 36.ssp.toDouble()),
            ),
            SizedBox(height: 13.h.toDouble()),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Input(
                    hintText: 'First Name',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h.toDouble()),
                  const Input(
                    hintText: 'Last Name',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h.toDouble()),
                  const Input(
                    hintText: 'Password',
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                  ),
                  SizedBox(height: 16.h.toDouble()),
                  const Input(
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
