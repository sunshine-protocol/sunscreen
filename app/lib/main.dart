import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keystore/keystore.dart';
import 'package:meta/meta.dart';
import 'blocs/blocs.dart';
import 'keys.dart';
import 'localization.dart';
import 'screens/screens.dart';
import 'styles.dart';

void main() {
  // Override is necessary to prevent Unknown platform' flutter startup error.
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSetup(
      child: MaterialApp(
        title: AppLocalizations().appTitle,
        theme: Styles.theme,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
        ],
        navigatorKey: Keys.navigatorKey,
        onGenerateRoute: (routeSettings) {
          print(routeSettings);
          switch (routeSettings.name) {
            case '/splash':
              return MaterialPageRoute(builder: (context) => SplashPage());
            case '/welcome':
              return MaterialPageRoute(builder: (context) => WelcomePage());
            case '/create_password':
              return MaterialPageRoute(builder: (context) => CreatePasswordPage());
            case '/account_image':
              return MaterialPageRoute(builder: (context) => AccountImagePage());
            case '/terms_of_use':
              return MaterialPageRoute(builder: (context) => TermsOfUsePage());
            case '/secret_backup':
              return MaterialPageRoute(builder: (context) => SecretBackupPage());
            case '/secret_confirm':
              return MaterialPageRoute(builder: (context) => SecretConfirmPage());
            case '/restore_account':
              return MaterialPageRoute(builder: (context) => RestoreAccountPage());
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginPage());
            case '/account_details':
              return MaterialPageRoute(builder: (context) => AccountDetailsPage());
            default:
              return MaterialPageRoute(builder: (context) => SplashPage());
          }
        },
      ),
    );
  }
}

class BlocSetup extends StatelessWidget {
  final Widget child;

  BlocSetup({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>(
      create: (context) => NavigatorBloc(navigatorKey: Keys.navigatorKey),
      child: RepositoryProvider<Keystore>(
        create: (context) => Keystore.fromKeyfile('keyfile'),
        child: Builder(
          builder: (context) {
            final keystore = RepositoryProvider.of<Keystore>(context);
            final navigator = BlocProvider.of<NavigatorBloc>(context);
            return BlocProvider<AccountBloc>(
              create: (context) => AccountBloc(
                keystore: keystore,
                navigator: navigator,
              )..add(Start()),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
