import 'dart:io';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/models/models.dart';

List<SingleChildWidget> buildProviders() => [
      ..._independentServices(),
      ..._dependentServices(),
      ..._uiConsumableProviders()
    ];

List<SingleChildWidget> _independentServices() => [
      FutureProvider(
        // we need to provide non null data at first
        initialData: PathProviderService(
          applicationDocumentsDirectory: Directory.current,
        ),
        create: (_) => PathProviderService.create(),
      ),
      Provider(
        create: (context) => AccountDetailsService(),
      ),
    ];

List<SingleChildWidget> _dependentServices() => [
      ProxyProvider<PathProviderService, KeystoreService>(
        update: (context, pp, _) {
          final path = pp.applicationDocumentsDirectory.path;
          print(path);
          return KeystoreService.fromKeyfile('$path/keystorefile');
        },
      ),
      ProxyProvider<KeystoreService, AccountService>(
        update: (context, kss, _) => AccountService(keystoreService: kss),
      )
    ];

List<SingleChildWidget> _uiConsumableProviders() => [
      StreamProvider<Account>(
        create: (context) => Provider.of<AccountService>(
          context,
          listen: false,
        ).account,
      ),
      StreamProvider<AccountDetails>(
        initialData: const AccountDetails(),
        create: (context) => Provider.of<AccountDetailsService>(
          context,
          listen: false,
        ).accountDetails,
      ),
    ];
