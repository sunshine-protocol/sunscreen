import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.accountDetailsTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.lock),
            tooltip: localizations.lockButtonTooltip,
            onPressed: () {
              BlocProvider.of<AccountBloc>(context).add(Lock());
            },
          ),
        ],
      ),
      body: Container(
        padding: Styles.containerPadding,
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Identicon(),
            SizedBox.fromSize(size: Size(1, 30)),
            AccountName(style: Styles.title),
            SizedBox.fromSize(size: Size(1, 30)),
            QrCode(),
            SizedBox.fromSize(size: Size(1, 30)),
            PublicKey(
              padding: Styles.containerPadding,
            ),
          ],
        ),
      ),
    );
  }
}
