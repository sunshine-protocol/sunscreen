import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class AccountPharseScreen extends StatelessWidget {
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
                  'Please place your phrase in a safe place.\n'
                  'You will be asked for your phrase in the following step.',
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
                readOnly: true,
              ),
              SizedBox(height: 32.h.toDouble()),
              Button(
                text: 'Copy',
                variant: ButtonVariant.thin,
                onPressed: () {},
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: 'Next Step',
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Routes.accountPharseConfirmation);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
