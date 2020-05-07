import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class AccountPharseConfirmationScreen extends StatelessWidget {
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
          'Account Pharse',
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
                  'Please enter your backup phrase to confirm.',
                  style: TextStyle(
                    fontSize: 16.ssp.toDouble(),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10.h.toDouble()),
              const Input(
                hintText: 'walrus thought faculty portion'
                    'music ginger slush awful give mechanic',
                maxLines: 3,
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
                  Navigator.of(context).popAndPushNamed(Routes.main);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
