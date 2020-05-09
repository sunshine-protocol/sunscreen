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

  bool isInitialized() {
    return state() != AccountState.noAccount;
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
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // TODO(shekohex): handle this error when there is already an account!
      return null;
    }
  }

  bool confirmBackup(AccountBackup backup, String phrase) {
    if (backup.phrase.compareTo(phrase) == 0) {
      _keystoreService.setPaperBackup();
      loadAccount();
      return true;
    } else {
      return false;
    }
  }

  bool restore(String phrase, AccountDetails details) {
    try {
      _keystoreService.import(phrase, details.password);
      loadAccount();
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print(e);
      return false;
    }
  }

  void loadAccount() {
    try {
      final account = _keystoreService.account();
      final name = account.name.split(' ');
      final acc = Account(
        address: account.ss58,
        firstName: name[0] ?? 'Unknwon',
        lastName: name[1] ?? 'Unknown',
        state: state(),
      );
      _accountController.add(acc);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print(e);
    }
  }

  void lock() {
    _keystoreService.lock();
  }

  bool unlock(String password) {
    try {
      _keystoreService.unlock(password);
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
