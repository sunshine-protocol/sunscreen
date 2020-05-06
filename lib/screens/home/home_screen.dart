import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: false,
    );
    // Dismis the keyboard
    FocusScope.of(context).unfocus();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Positioned(
            bottom: 38.h.toDouble(),
            child: Text(
              'v0.1.0',
              style: TextStyle(
                fontSize: 15.ssp.toDouble(),
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(flex: 3),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.w.toDouble()),
                  child: Text(
                    'Welcome to the Sunshine Foundation app.',
                    style: TextStyle(
                      fontSize: 22.ssp.toDouble(),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 46.h.toDouble()),
              Flexible(
                flex: 2,
                child: Button(
                  text: 'Generate account',
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.generateAccount);
                  },
                ),
              ),
              SizedBox(height: 16.h.toDouble()),
              Flexible(
                flex: 1,
                child: Button(
                  text: 'Restore from key-phrase',
                  variant: ButtonVariant.success,
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
