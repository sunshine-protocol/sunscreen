import 'device_model.dart';
import 'identity/service.dart';

enum AccountState {
  unknown,
  noAccount,
  locked,
  unlocked,
}

class Account {
  const Account({
    this.uid,
    this.state,
    this.devices,
    this.identities,
  });
  final String uid;
  final AccountState state;
  final List<Device> devices;
  final List<SocialIdentityService> identities;
  Device get currentDevice => devices.firstWhere((d) => d.isCurrentDevice);
}
