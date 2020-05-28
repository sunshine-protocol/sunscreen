import 'package:flutter/material.dart';
import 'package:sunshine/screens/main/widgets/information_line.dart';
import 'package:sunshine/sunshine.dart';

class BountyInfoView extends StatelessWidget {
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
          'Bounty Information',
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
                  'Open Grants Program',
                  style: TextStyle(
                    fontSize: 28.ssp.toDouble(),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10.h.toDouble()),
              const InformationLine(
                leadingText: '☼ 10,000',
                secondaryText: '☼ 2,000 / team',
              ),
              SizedBox(height: 10.h.toDouble()),
              Padding(
                padding: EdgeInsets.all(
                  10.w.toDouble(),
                ),
                child: Text(
                  'This program offers funding for smaller technical grants of up to \$30k.'
                  ' These applications are tracked transparently on GitHub and disbursed '
                  'in cryptocurrencies',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 14.ssp.toDouble(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: 'Apply',
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
