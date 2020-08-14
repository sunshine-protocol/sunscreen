import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class WalletService {
  WalletService({ClientService clientService}) : _clientService = clientService;

  final ClientService _clientService;

  Future<String> balance() {
    return _clientService.balance();
  }

  Future<String> transfer(String to, BigInt amount) {
    return _clientService.transfer(to, amount);
  }

  Future<BigInt> mint() async {
    // Enable mint account when he tap in his balance
    // this just for testing ...
    if (kDebugMode) {
      return _clientService.mint();
    } else {
      return BigInt.zero;
    }
  }
}
