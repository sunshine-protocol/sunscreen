import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class WalletService {
  WalletService({ClientService clientService}) : _clientService = clientService;

  final ClientService _clientService;

  Future<String> balance() {
    return _clientService.balance();
  }

  Future<String> transfer(String to, int amount) {
    return _clientService.transfer(to, amount);
  }

  Future<int> mint() async {
    // TODO(shekohex): you should add these flags back
    // Enable mint account when he tap in his balance
    // this just for testing ...
    // if (kDebugMode) {
    return _clientService.mint();
    // } else {
    // return 0;
    // }
  }
}
