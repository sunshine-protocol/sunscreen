import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/setup.dart';
import 'package:sunshine/sunshine.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configure();
  runApp(MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Sunshine',
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        initialRoute: Routes.home,
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  Route _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case Routes.recoverAccount:
        return MaterialPageRoute(builder: (_) => RecoverAccountScreen());
      case Routes.generateAccount:
        return MaterialPageRoute(builder: (_) => GenerateAccountScreen());
      case Routes.accountPharse:
        return MaterialPageRoute(
          builder: (_) => AccountPharseScreen(
            // ignore: argument_type_not_assignable
            accountBackup: settings.arguments,
          ),
        );
      case Routes.accountPharseConfirmation:
        return MaterialPageRoute(
          builder: (_) => AccountPharseConfirmationScreen(
            // ignore: argument_type_not_assignable
            accountBackup: settings.arguments,
          ),
        );
      case Routes.unloackAccount:
        return MaterialPageRoute(
          builder: (_) => UnlockAccountScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
