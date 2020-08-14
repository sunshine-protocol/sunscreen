import 'package:sunshine/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:sunshine_ffi/sunshine_client.dart';

@lazySingleton
class SunshineClientService extends SunshineClient {
  SunshineClientService({PathProviderService pathProviderService})
      : super(
          root: pathProviderService.applicationDocumentsDirectory,
          url: 'ws://51.11.244.93:9944',
        );
}
