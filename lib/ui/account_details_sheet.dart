import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';

class AccountDetailsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountDetails = Provider.of<AccountDetails>(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: 700.h.toDouble(),
      ),
      decoration: BoxDecoration(
        color: AppColors.mainBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 120.w.toDouble(),
              vertical: 4.h.toDouble(),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Divider(
                thickness: 5.h.toDouble(),
                color: Colors.black45,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 42.h.toDouble(),
              left: 8.w.toDouble(),
            ),
            child: Column(
              children: [
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 24.ssp.toDouble(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22.h.toDouble()),
                Input(
                  hintText: accountDetails.firstName ?? 'First Name',
                ),
                SizedBox(height: 14.h.toDouble()),
                Input(
                  hintText: accountDetails.lastName ?? 'Last Name',
                ),
                SizedBox(height: 22.h.toDouble()),
                Button(
                  text: 'Save',
                  variant: ButtonVariant.thin,
                  onPressed: () {},
                ),
                SizedBox(height: 32.h.toDouble()),
                const Input(
                  readOnly: true,
                  hintText: '0x235985604983045987FA13....',
                ),
                SizedBox(height: 4.h.toDouble()),
                Text(
                  // TODO(shekohex): impl copy address to clipboard
                  'Long Press to copy your address to clipboard!',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 48.h.toDouble()),
                Button(
                  text: 'Show Public Key QR Code',
                  variant: ButtonVariant.thin,
                  onPressed: () {
                    // TODO(shekohex): make use of public key qr code from keystore!
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
