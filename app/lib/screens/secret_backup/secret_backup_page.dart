import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class SecretBackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.secretBackupTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Identicon(),
            SizedBox.fromSize(size: Size(1, 30)),
            Text(
              localizations.secretBackupTitle,
              style: Styles.title,
            ),
            SizedBox.fromSize(size: Size(1, 8)),
            Card(
              child: ListTile(
                title: Text(localizations.secretBackupDescription),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.warning),
                title: Text(localizations.secretBackupDisclaimer),
              ),
            ),
            Card(
              child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  final phrase = state is PaperBackup
                    ? state.phrase
                    : null;
                  return ListTile(
                    leading: Icon(Icons.vpn_key),
                    title: Text(phrase ?? ''),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text(localizations.secretBackupTips),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context)
                      .add(PostponeBackup());
                  },
                  child: Text(localizations.secretBackupRemindButton),
                ),
                SizedBox.fromSize(size: Size(8, 1)),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/secret_confirm');
                  },
                  child: Text(localizations.secretBackupNextButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
