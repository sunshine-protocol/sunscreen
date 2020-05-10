import 'package:injectable/injectable.dart';
import 'package:keystore/keystore.dart';
import 'package:sunshine/services/services.dart';

@lazySingleton
class KeystoreService extends Keystore {
  KeystoreService({PathProviderService pathProviderService})
      : super.fromKeyfile(
            '${pathProviderService.applicationDocumentsDirectory.path}/keyfile');
}
