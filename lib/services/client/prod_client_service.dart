import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/identity/service.dart';
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
  Future<bool> hasDeviceKey() {
    return _identityClientService.hasDeviceKey();
  }

  @override
  Future<bool> get ready => _identityClientService.ready;

  @override
  Future<String> deviceId() async {
    return _identityClientService.currentDevice();
  }

  @override
  Future<String> addPaperKey() {
    return _identityClientService.addPaperKey();
  }

  @override
  Future<List<String>> identities(String uid) async {
    return _identityClientService.listIdentities(uid);
  }

  @override
  Future<bool> lock() {
    return _identityClientService.lockKey();
  }

  @override
  Future<ProveIdentityResult> proveIdentity(
      SocialIdentityService service) async {
    final result = await _identityClientService.proveIdentity(service.display);
    return ProveIdentityResult(result[0], result[1]);
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
  Future<bool> addDevice(String id) {
    return _identityClientService.addDevice(id);
  }

  @override
  Future<String> balance() async {
    return _identityClientService
        .balance(await uid())
        .then((value) => value.toString());
  }

  @override
  Future<List<String>> devices() async {
    return _identityClientService.listDevices(await uid());
  }

  @override
  Future<bool> revokeDevice(String id) {
    return _identityClientService.removeDevice(id);
  }

  @override
  Future<bool> revokeIdentity(SocialIdentityService service) {
    return _identityClientService.revokeIdentity(service.display);
  }

  @override
  Future<String> transfer(String id, int amount) {
    return _identityClientService.transfer(id, amount);
  }

  @override
  Future<String> uid() async {
    final did = await deviceId();
    return _identityClientService.resolveUid(did);
  }

  @override
  Future<int> mint() {
    return _identityClientService.mint();
  }

  @override
  Future<String> uidOf(String id) {
    return _identityClientService.resolveUid(id);
  }
}
