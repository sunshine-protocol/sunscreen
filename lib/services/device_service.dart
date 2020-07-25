import 'package:sunshine/models/models.dart';
import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class DeviceService {
  DeviceService({ClientService clientService}) : _clientService = clientService;
  final ClientService _clientService;

  Future<bool> hasDeviceKey() {
    return _clientService.hasDeviceKey();
  }

  Future<List<Device>> devices() {
    return _clientService.devices().then((v) => v
        .map(
          (e) => Device(
            id: e,
            currentDevice: false,
          ),
        )
        .toList());
  }

  Future<bool> addDevice(String deviceId) {
    return _clientService.addDevice(deviceId);
  }

  Future<bool> revokeDevice(String deviceId) {
    return _clientService.revokeDevice(deviceId);
  }

  Future<String> addPaperKey() {
    return _clientService.addPaperKey();
  }
}
