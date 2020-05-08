import 'dart:async';

import 'package:keystore/keystore.dart' show Status;
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';
import 'package:meta/meta.dart';

class AccountService {
  AccountService({@required KeystoreService keystoreService})
      : _keystoreService = keystoreService;

  final KeystoreService _keystoreService;
  final _accountController = StreamController<Account>();

  Stream<Account> get account => _accountController.stream;

  AccountState state() {
    final status = _keystoreService.status();
    switch (status) {
      case Status.uninitialized:
        return AccountState.noAccount;
      case Status.locked:
        return AccountState.locked;
      case Status.unlocked:
        return AccountState.unlocked;
      default:
        return AccountState.unknown;
    }
  }

  bool isLocked() {
    return state() == AccountState.locked;
  }

  bool isUnlocked() {
    return state() == AccountState.unlocked;
  }

  AccountBackup generate(AccountDetails details) {
    try {
      _keystoreService.generate(details.password);
      // TODO(shekohex): use qrcode from here
      final account = _keystoreService.account();
      final phrase = _keystoreService.phrase(details.password);
      final acc = Account(
        firstName: details.firstName,
        lastName: details.lastName,
        address: account.ss58,
      );
      _accountController.add(acc);
      return AccountBackup(
        account: acc,
        phrase: phrase,
      );
    } on Exception catch (_) {
      // TODO(shekohex): handle this error when there is already an account!
      return null;
    }
  }

  bool confirmBackup(AccountBackup backup, String phrase) {
    if (backup.phrase.compareTo(phrase) == 0) {
      _keystoreService.setPaperBackup();
      return true;
    } else {
      return false;
    }
  }

  Account restore(String phrase, AccountDetails details) {
    try {
      _keystoreService.import(phrase, details.password);
      final account = _keystoreService.account();
      final acc = Account(
        address: account.ss58,
        firstName: details.firstName,
        lastName: details.lastName,
      );
      _accountController.add(acc);
      return acc;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  void lock() {
    _keystoreService.lock();
  }

  bool unlock(String password) {
    try {
      _keystoreService.unlock(password);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
