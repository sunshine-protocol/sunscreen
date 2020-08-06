import 'package:injectable/injectable.dart';

import 'client_service.dart';

@dev
@LazySingleton(as: ClientService)
class DevClientService implements ClientService {
  String _uid;
  String _balance;
  String _password;
  @override
  @override
  Future<bool> hasKey() async {
    return _uid != null;
  }

  @override
  Future<bool> get ready => Future.delayed(
        const Duration(seconds: 2),
        () => true,
      );

  @override
  Future<bool> lock() async {
    return true;
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    _password = password;
    _uid = '1';
    _balance = '0';
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
  Future<String> balance() async {
    return _balance ?? '100000000';
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
  Future<int> mint() async {
    _balance = (int.parse(_balance) + 1000000).toString();
    return 1000000;
  }
}
