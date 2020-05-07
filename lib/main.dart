import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sunshine',
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        initialRoute: Routes.home,
        // TODO:(@shekohex): replace this by onGenerateRoutes
        routes: {
          Routes.home: (_) => HomeScreen(),
          Routes.recoverAccount: (_) => RecoverAccountScreen(),
          Routes.generateAccount: (_) => GenerateAccountScreen(),
          Routes.accountPharse: (_) => AccountPharseScreen(),
          Routes.accountPharseConfirmation: (_) =>
              AccountPharseConfirmationScreen(),
        },
      );
}
