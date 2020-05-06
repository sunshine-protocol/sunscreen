import 'package:flutter/material.dart';
import '../../localization.dart';
import '../../styles.dart';
import '../../widgets/widgets.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.termsOfUseTitle),
      ),
      body: Container(
        padding: Styles.containerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Identicon(),
            SizedBox.fromSize(size: Size(1, 30)),
            Text(
              localizations.termsOfUseTitle,
              style: Styles.title,
            ),
            SizedBox.fromSize(size: Size(1, 8)),
            ScrollableTextAsset('assets/terms_of_use.txt'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/secret_backup');
                  },
                  child: Text(localizations.termsOfUseAcceptButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
