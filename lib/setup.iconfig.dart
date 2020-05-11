// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:sunshine/services/account_details_service.dart';
import 'package:sunshine/services/path_provider_service.dart';
import 'package:sunshine/core/register_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunshine/ui/account_details_form/account_details_form_view_model.dart';
import 'package:sunshine/services/keystore_service.dart';
import 'package:sunshine/services/account_service.dart';
import 'package:sunshine/screens/generate_account/generate_account_view_model.dart';
import 'package:sunshine/screens/home/home_view_model.dart';
import 'package:sunshine/screens/recover_account/recover_account_view_model.dart';
import 'package:sunshine/screens/unlock_account/unlock_account_view_model.dart';
import 'package:sunshine/ui/account_details_sheet/account_details_sheet_view_model.dart';
import 'package:sunshine/screens/account_pharse_confirmation/account_pharse_confirmation_view_model.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final registerModule = _$RegisterModule();
  g.registerLazySingleton<AccountDetailsService>(() => AccountDetailsService());
  final pathProviderService = await registerModule.pathProvider;
  g.registerLazySingleton<PathProviderService>(() => pathProviderService);
  final sharedPreferences = await registerModule.prefs;
  g.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  g.registerFactory<AccountDetailsFormViewModel>(() =>
      AccountDetailsFormViewModel(
          accountDetailsService: g<AccountDetailsService>()));
  g.registerLazySingleton<KeystoreService>(
      () => KeystoreService(pathProviderService: g<PathProviderService>()));
  g.registerLazySingleton<AccountService>(() => AccountService(
      keystoreService: g<KeystoreService>(),
      preferences: g<SharedPreferences>()));
  g.registerFactory<GenerateAccountViewModel>(() => GenerateAccountViewModel(
      accountService: g<AccountService>(),
      accountDetailsService: g<AccountDetailsService>()));
  g.registerFactory<HomeViewModel>(
      () => HomeViewModel(accountService: g<AccountService>()));
  g.registerFactory<RecoverAccountViewModel>(
      () => RecoverAccountViewModel(accountService: g<AccountService>()));
  g.registerFactory<UnlockAccountViewModel>(
      () => UnlockAccountViewModel(accountService: g<AccountService>()));
  g.registerFactory<AccountDetailsSheetViewModel>(
      () => AccountDetailsSheetViewModel(accountService: g<AccountService>()));
  g.registerFactory<AccountPharseConfirmationViewModel>(() =>
      AccountPharseConfirmationViewModel(accountService: g<AccountService>()));
}

class _$RegisterModule extends RegisterModule {}
