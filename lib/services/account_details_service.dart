import 'dart:async';

import 'package:sunshine/models/models.dart';

class AccountDetailsService {
  final _accountDetailsController = StreamController<AccountDetails>();

  Stream<AccountDetails> get accountDetails => _accountDetailsController.stream;

  void update(AccountDetails details) {
    _accountDetailsController.add(details);
  }
}
