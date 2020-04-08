import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text(localizations.welcomeTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Logo(),
            SizedBox.fromSize(size: Size(1, 30)),
            Text(
              localizations.welcomeTitle,
              style: Styles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(size: Size(1, 20)),
            Text(
              localizations.welcomeMessage,
              style: Styles.message,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create_password');
                  },
                  child: Text(localizations.welcomeContinueButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
