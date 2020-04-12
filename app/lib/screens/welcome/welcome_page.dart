import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return FluidScaffold(
      appBar: AppBar(
        title: Text(localizations.welcomeTitle),
      ),
      body: TwoRowsOrColumn(
        left: [
          Logo(),
        ],
        right: [
          PageWidget(
            content: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    localizations.welcomeTitle,
                    style: Styles.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  localizations.welcomeMessage,
                  style: Styles.message,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            footer: [
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
    );
  }
}
