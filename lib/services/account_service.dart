import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';
import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class AccountService {
  AccountService({ClientService clientService})
      : _clientService = clientService;

  final ClientService _clientService;

  Future<Account> currentAccount() async {
    final uid = await _clientService.uid();
    return Account(
      uid: uid,
    );
  }

  Future<String> uid() {
    return _clientService.uid();
  }
}
