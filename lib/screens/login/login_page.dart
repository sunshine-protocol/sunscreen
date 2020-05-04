import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return FluidScaffold(
      appBar: AppBar(
        title: Text(localizations.loginTitle),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          List<Widget> children = [];
          if (height > 500) {
            children.add(Logo());
          }
          if (height > 200) {
            children.addAll([
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
            ]);
          }
          children.add(
            UnlockForm(
              padding: Styles.containerPadding,
              passwordLabel: localizations.unlockFormPasswordLabel,
              validationError: localizations.unlockFormValidationError,
              unlockButton: localizations.unlockFormUnlockButton,
            )
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        },
      ),
    );
  }
}
