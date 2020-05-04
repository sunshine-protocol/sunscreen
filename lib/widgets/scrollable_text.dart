import 'package:flutter/material.dart';
import '../styles.dart';

class ScrollableTextAsset extends StatelessWidget {
  final String asset;

  ScrollableTextAsset(this.asset);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(asset),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: Card(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: Styles.containerPadding,
                    child: Text(snapshot.data),
                  ),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
