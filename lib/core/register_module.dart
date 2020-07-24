import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunshine/services/services.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  @preResolve
  Future<PathProviderService> get pathProvider => PathProviderService.create();
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
