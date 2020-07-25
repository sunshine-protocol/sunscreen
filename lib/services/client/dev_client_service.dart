import 'package:sunshine/models/identity/service.dart';
import 'package:injectable/injectable.dart';

import 'client_service.dart';

@dev
@LazySingleton(as: ClientService)
class DevClientService implements ClientService {
  String _uid;
  String _deviceId;
  String _balance;
  String _password;
  final Map<String, Set<String>> _identities = {};
  final Map<String, Set<String>> _devices = {};
  @override
  Future<String> deviceId() async {
    return _deviceId;
  }

  @override
  Future<String> addPaperKey() async {
    const paperKey = 'mandate robust earth scan shrimp second pipe pitch'
        ' eternal snap glare tooth bean crucial river bar'
        ' crash nice sorry laundry oppose filter aunt swear';
    return paperKey;
  }

  @override
  Future<bool> hasDeviceKey() async {
    return _uid != null;
  }

  @override
  Future<bool> get ready => Future.delayed(
        const Duration(seconds: 2),
        () => true,
      );

  @override
  Future<List<String>> identities(String uid) async {
    return _identities[uid].toList();
  }

  @override
  Future<bool> lock() async {
    return true;
  }

  @override
  Future<ProveIdentityResult> proveIdentity(
      SocialIdentityService service) async {
    _identities[_uid].add(service.display);
    if (service.serviceName == 'github') {
      return const ProveIdentityResult(
        'Login to your Github account and paste the text below'
        ' into a Public gist called substrate-identity-proof.md',
        instractionsForDemo,
      );
    } else {
      return null;
    }
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    _password = password;
    _uid = '1';
    _deviceId = '5GrwvaEF5zXb26Fz9rcQpDWS57CEfgh';
    _identities[_uid] = {'5GrwvaEF5zXb26Fz9rcQpDWS57CEfgh'};
    _devices[_uid] = {};
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return _uid;
  }

  @override
  Future<bool> unlock(String password) async {
    if (password == _password) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addDevice(String id) async {
    return _devices[_uid].add(id);
  }

  @override
  Future<String> balance() async {
    return _balance;
  }

  @override
  Future<List<String>> devices() async {
    return _devices[_uid].toList();
  }

  @override
  Future<bool> revokeDevice(String id) async {
    return _devices[_uid].remove(id);
  }

  @override
  Future<bool> revokeIdentity(SocialIdentityService service) async {
    return _identities[_uid].remove(service.display);
  }

  @override
  Future<String> transfer(String id, int amount) {
    throw UnimplementedError();
  }

  @override
  Future<String> uid() async {
    return _uid;
  }

  @override
  Future<int> mint() {
    throw UnimplementedError();
  }

  @override
  Future<String> uidOf(String id) {
    throw UnimplementedError();
  }
}

const instractionsForDemo = '''
### substrate identity proof

I hereby claim:

  * I am shekohex on github.
  * I am 0 on the substrate chain with genesis hash mzyTJZVm7IXDUBeZwyWk6rG1YGIt8BQnNzrshKJCalYI.
  * I have a public key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY valid at block with hash mfBFseDYNX31Poqei8A/9teYmxJIj4PFROoKLKEPaStE.

To claim this, I am signing this object:

{"block":[124,17,108,120,54,13,95,125,79,162,167,162,240,15,253,181,230,38,196,146,35,224,241,81,58,130,139,40,67,218,74,209],"body":{"Ownership":[{"Github":["dvc94ch"]}]},"ctime":1591448931056,"expire_in":18446744073709551615,"genesis":[207,36,201,101,89,187,33,112,212,5,230,112,201,105,58,172,109,88,24,139,124,5,9,205,206,187,33,40,144,154,149,130],"prev":null,"public":"5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY","seqno":1,"uid":0}

with the key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY, yielding the signature:

mAU6Gon1dqctnS/zPKHd9gWFvEJBqADvgYQy0OFuamA5CwVQk7papR0xBq8DijRqSXVGpJtNFmy7aYJk5cGLxv4c

And finally, I am proving ownership of the github account by posting this as a gist.
''';
