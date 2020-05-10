import 'package:injectable/injectable.dart';
import 'package:sunshine/services/services.dart';

@registerModule
abstract class RegisterModule {
  @lazySingleton
  @preResolve
  Future<PathProviderService> get pathProvider => PathProviderService.create();
}
