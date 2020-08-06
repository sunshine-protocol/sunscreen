import 'package:sunshine/sunshine.dart';
import 'package:injectable/injectable.dart';

import 'client_service.dart';
import 'identity_client_service.dart';

@prod
@LazySingleton(as: ClientService)
class ProdClientService implements ClientService {
  ProdClientService({IdentityClientService identityClientService})
      : _identityClientService = identityClientService;
  final IdentityClientService _identityClientService;

  @override
  Future<bool> get ready => _identityClientService.ready;

  @override
  Future<bool> lock() {
    return _identityClientService.lockKey();
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    return _identityClientService.setKey(
      password,
      suri: suri,
      paperKey: paperKey,
    );
  }

  @override
  Future<bool> unlock(String password) {
    return _identityClientService.unlockKey(password);
  }

  @override
  Future<String> balance() async {
    return _identityClientService
        .balance(await uid())
        .then((value) => value.toString());
  }

  @override
  Future<String> transfer(String id, int amount) {
    return _identityClientService.transfer(id, amount);
  }

  @override
  Future<String> uid() async {
    return _identityClientService.resolveUid('');
  }

  @override
  Future<int> mint() {
    return _identityClientService.mint();
  }

  @override
  Future<bool> hasKey() {
    throw UnimplementedError();
  }
}
