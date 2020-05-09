// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:sunshine/services/path_provider_service.dart';
import 'package:sunshine/setup.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final registerModule = _$RegisterModule();
  final pathProviderService = await registerModule.pathProvider;
  g.registerFactory<PathProviderService>(() => pathProviderService);
}

class _$RegisterModule extends RegisterModule {}
