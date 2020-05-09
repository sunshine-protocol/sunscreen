import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/sunshine.dart';

class AccountDetailsModel extends BaseModel {
  AccountDetailsModel({
    @required this.accountService,
  });
  final AccountService accountService;
  Account account;
  void loadAccount() {
    busy();
    account = accountService.loadAccount();
    idle();
  }
}

class AccountDetailsSheet extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountDetailsModel>(
      model: AccountDetailsModel(accountService: context.watch()),
      onModelReady: (model) => model.loadAccount(),
      builder: (context, model, _) => Container(
        constraints: BoxConstraints(
          maxHeight: 700.h.toDouble(),
        ),
        decoration: BoxDecoration(
          color: AppColors.mainBackground,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
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
                        hintText: model.account?.firstName ?? 'First Name',
                      ),
                      SizedBox(height: 14.h.toDouble()),
                      Input(
                        hintText: model.account?.lastName ?? 'Last Name',
                      ),
                      SizedBox(height: 22.h.toDouble()),
                      Button(
                        text: 'Save',
                        variant: ButtonVariant.thin,
                        onPressed: () {},
                      ),
                      SizedBox(height: 32.h.toDouble()),
                      Row(
                        children: [
                          Expanded(
                            child: Input(
                              readOnly: true,
                              hintText: model.account?.address ??
                                  '0x235985604983045987FA13....',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: model.account?.address ?? '',
                                  ),
                                );
                                const snackBar = SnackBar(
                                  content: Text('Copied to clipboard!'),
                                  behavior: SnackBarBehavior.floating,
                                );
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                                debugPrint('Copied!');
                              },
                              child: Icon(
                                Icons.assignment,
                                color: AppColors.secondry,
                                size: 32.ssp.toDouble(),
                              ),
                            ),
                          ),
                        ],
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
          ),
        ),
      ),
    );
  }
}
