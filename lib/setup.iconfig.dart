// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:sunshine/services/client/dev_client_service.dart';
import 'package:sunshine/services/client/client_service.dart';
import 'package:sunshine/services/github_service.dart';
import 'package:sunshine/services/key_service.dart';
import 'package:sunshine/services/path_provider_service.dart';
import 'package:sunshine/core/register_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunshine/services/client/sunshine_client_service.dart';
import 'package:sunshine/services/wallet_service.dart';
import 'package:sunshine/services/account_service.dart';
import 'package:sunshine/services/client/prod_client_service.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final registerModule = _$RegisterModule();
  g.registerFactory<GithubService>(() => GithubService());
  g.registerLazySingleton<KeyService>(
      () => KeyService(clientService: g<ClientService>()));
  final pathProviderService = await registerModule.pathProvider;
  g.registerLazySingleton<PathProviderService>(() => pathProviderService);
  final sharedPreferences = await registerModule.prefs;
  g.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  g.registerLazySingleton<SunshineClientService>(() =>
      SunshineClientService(pathProviderService: g<PathProviderService>()));
  g.registerLazySingleton<WalletService>(
      () => WalletService(clientService: g<ClientService>()));
  g.registerLazySingleton<AccountService>(
      () => AccountService(clientService: g<ClientService>()));

  //Register dev Dependencies --------
  if (environment == 'dev') {
    g.registerLazySingleton<ClientService>(() => DevClientService());
  }

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<ClientService>(() =>
        ProdClientService(sunshineClientService: g<SunshineClientService>()));
  }
}

class _$RegisterModule extends RegisterModule {}
