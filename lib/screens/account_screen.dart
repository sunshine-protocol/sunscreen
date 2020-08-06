import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunshine/sunshine.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
  final _accountService = GetIt.I.get<AccountService>();
  final _walletService = GetIt.I.get<WalletService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Account', elevation: 1),
      body: ListView(
        children: [
          const HeaderText('Your Information'),
          SizedBox(height: 15.w.toDouble()),
          const HintText('Tip: long press to copy to clipboard'),
          SizedBox(height: 10.w.toDouble()),
          ListCell(
            title: 'UID',
            trailing: SizedBox(
              width: 60.w.toDouble(),
              child: FutureBuilder<String>(
                initialData: '...',
                future: _accountService.uid(),
                builder: (context, snapshot) {
                  return HintText(
                    snapshot.data ?? 'N/A',
                  );
                },
              ),
            ),
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: await _accountService.uid(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
            color: AppColors.disabled,
          ),
          ListCell(
            title: 'Balance',
            trailing: SizedBox(
              width: 120.w.toDouble(),
              child: FutureBuilder<String>(
                initialData: '...',
                future: _walletService.balance(),
                builder: (context, snapshot) {
                  return HintText(
                    '☼${snapshot.data}' ?? 'N/A',
                  );
                },
              ),
            ),
            onTap: () async {
              try {
                await _walletService.mint();
              } catch (_) {
                // don't do anything, it is only for testing ..
              }
            },
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: await _walletService.balance(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
            color: AppColors.disabled,
          ),
          SizedBox(height: 20.w.toDouble()),
          const HeaderText('Legal'),
          SizedBox(height: 10.w.toDouble()),
          ListCell(
            title: 'About',
            trailing: const Icon(
              Icons.share,
              size: 22,
              color: Colors.white,
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Sunshine',
                applicationVersion: 'v0.1.0',
                applicationIcon: const SunshineLogo(),
                useRootNavigator: true,
                applicationLegalese: 'Powered by Substrate',
                children: [
                  const SizedBox(height: 10),
                  FlatButton(
                    child: const Text('Website'),
                    onPressed: () {
                      launch('https://sunshine.foundation/');
                    },
                  ),
                ],
              );
            },
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
            color: AppColors.disabled,
          ),
        ],
      ),
    );
  }
}
