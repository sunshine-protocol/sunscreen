import 'package:sunshine/services/services.dart';
import 'package:injectable/injectable.dart';
import 'package:sunshine_ffi/sunshine_client.dart';

@lazySingleton
class SunshineClientService extends SunshineClient {
  SunshineClientService({PathProviderService pathProviderService})
      : super(
          root: pathProviderService.applicationDocumentsDirectory,
          chainspecPath: Uri(path: 'assets/chainspec.json'),
        );
}
