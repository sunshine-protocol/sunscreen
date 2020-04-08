import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class SecretConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.secretConfirmTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Identicon(),
            SizedBox.fromSize(size: Size(1, 30)),
            Text(
              localizations.secretConfirmTitle,
              style: Styles.title,
            ),
            SizedBox.fromSize(size: Size(1, 30)),
            Card(
              child: ListTile(
                title: Text(localizations.secretConfirmMessage),
              ),
            ),
            SizedBox.fromSize(size: Size(1, 20)),
            PaperBackupForm(
              padding: Styles.containerPadding,
              secretLabel: localizations.secretFormFieldLabel,
              secretMissmatchError: localizations.paperBackupFormSecretMissmatchError,
              confirmButton: localizations.paperBackupFormConfirmButton,
            ),
          ],
        ),
      ),
    );
  }
}
