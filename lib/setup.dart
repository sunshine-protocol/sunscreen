import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/setup.iconfig.dart';

final _getIt = GetIt.instance;

@injectableInit
Future configure() async => await $initGetIt(_getIt);

@registerModule
abstract class RegisterModule {
  @preResolve
  Future<PathProviderService> get pathProvider => PathProviderService.create();
}

List<SingleChildWidget> providers = [
  ..._independentServices,
  ..._dependentServices,
  ..._uiConsumableProviders
];

List<SingleChildWidget> _independentServices = [
  Provider(
    create: (_) => AccountDetailsService(),
  ),
];

List<SingleChildWidget> _dependentServices = [
  Provider<KeystoreService>(
    create: (context) {
      final pp = _getIt.get<PathProviderService>();
      final path = pp.applicationDocumentsDirectory.path;
      return KeystoreService.fromKeyfile('$path/keystorefile');
    },
  ),
  ProxyProvider<KeystoreService, AccountService>(
    update: (context, ks, _) => AccountService(keystoreService: ks),
  )
];

List<SingleChildWidget> _uiConsumableProviders = [
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
