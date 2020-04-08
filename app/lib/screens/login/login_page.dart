import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.loginTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Logo(),
            SizedBox.fromSize(size: Size(1, 30)),
            Text(
              localizations.loginTitle,
              style: Styles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(size: Size(1, 20)),
            Text(
              localizations.loginMessage,
              style: Styles.message,
              textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(size: Size(1, 20)),
            UnlockForm(
              padding: Styles.containerPadding,
              passwordLabel: localizations.unlockFormPasswordLabel,
              validationError: localizations.unlockFormValidationError,
              unlockButton: localizations.unlockFormUnlockButton,
            ),
          ],
        ),
      ),
    );
  }
}
