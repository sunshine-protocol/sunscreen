import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';
import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class AccountService {
  AccountService(
      {ClientService clientService,
      IdentityService identityService,
      DeviceService deviceService})
      : _clientService = clientService,
        _identityService = identityService,
        _deviceService = deviceService;

  final ClientService _clientService;
  final IdentityService _identityService;
  final DeviceService _deviceService;

  Future<Account> currentAccount() async {
    final uid = await _clientService.uid();
    final deviceId = await _clientService.deviceId();
    final device = Device(id: deviceId, currentDevice: true);
    final devices = await _deviceService.devices();
    devices.removeWhere((element) => element.id == deviceId);
    final identities = await _identityService.identities(uid);
    return Account(
      devices: [device, ...devices],
      uid: uid,
      identities: identities,
    );
  }

  Future<List<SocialIdentityService>> identities() async {
    final uid = await _clientService.uid();
    return _identityService.identities(uid);
  }

  Future<List<Device>> devices() async {
    final deviceId = await _clientService.deviceId();
    final device = Device(id: deviceId, currentDevice: true);
    final devices = await _deviceService.devices();
    devices.removeWhere((element) => element.id == deviceId);
    return [device, ...devices];
  }

  Future<Device> currentDevice() async {
    final deviceId = await _clientService.deviceId();
    return Device(id: deviceId, currentDevice: true);
  }

  Future<String> uid() {
    return _clientService.uid();
  }
}
