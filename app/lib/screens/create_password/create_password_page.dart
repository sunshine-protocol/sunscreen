import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class CreatePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.createPasswordTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.createPasswordTitle,
              style: Styles.title,
            ),
            SizedBox.fromSize(size: Size(1, 30)),
            CreateAccountForm(
              padding: Styles.containerPadding,
              newPasswordLabel: localizations.newPasswordFormFieldNewPasswordLabel,
              passwordLengthError: localizations.newPasswordFormFieldLengthError,
              confirmPasswordLabel: localizations.newPasswordFormFieldConfirmPasswordLabel,
              passwordMissmatchError: localizations.newPasswordFormFieldMissmatchError,
              importButton: localizations.createAccountFormImportButton,
              createButton: localizations.createAccountFormCreateButton,
            ),
          ],
        ),
      ),
    );
  }
}
