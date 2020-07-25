import 'package:sunshine/services/services.dart';
import 'package:sunshine_ffi/identity_client.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IdentityClientService extends IdentityClient {
  IdentityClientService({PathProviderService pathProviderService})
      : super(
          root: pathProviderService.applicationDocumentsDirectory,
          chainspecPath: Uri(path: 'assets/chainspec.json'),
        );
}
