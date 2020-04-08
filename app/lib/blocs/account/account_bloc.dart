import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:keystore/keystore.dart';
import 'package:meta/meta.dart';
import '../blocs.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final Keystore keystore;
  final NavigatorBloc navigator;

  AccountBloc({
    @required this.keystore,
    @required this.navigator,
  });

  @override
  AccountState get initialState => Unknown();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is Start) {
      final status = keystore.status();
      switch (status) {
        case Status.Uninitialized:
          yield NoAccount();
          navigator.add(PushNamed('/welcome'));
          break;
        case Status.Locked:
          yield Locked(error: false);
          navigator.add(PushNamed('/login'));
          break;
        case Status.Unlocked:
          final account = await keystore.account();
          yield Unlocked(account: account);
          navigator.add(PushNamed('/account_details'));
          break;
      }
    }
    if (event is Generate) {
      keystore.generate(event.password);
      final account = keystore.account();
      final phrase = keystore.phrase(event.password);
      yield PaperBackup(account: account, phrase: phrase, error: false);
      navigator.add(PushNamed('/account_image'));
    }
    if (event is Import) {
      try {
        keystore.import(event.phrase, event.password);
        final account = keystore.account();
        yield Unlocked(account: account);
        navigator.add(PushNamed('/account_details'));
      } on PlatformException catch (error) {
        yield ImportFailed(error: error.message);
      }
    }
    if (event is Lock) {
      navigator.add(PushNamed('/login'));
      keystore.lock();
      yield Locked(error: false);
    }
    if (event is Unlock) {
      try {
        keystore.unlock(event.password);
        final paperBackup = keystore.paperBackup();
        final account = keystore.account();
        if (paperBackup) {
          yield Unlocked(account: account);
          navigator.add(PushNamed('/account_details'));
        } else {
          final phrase = keystore.phrase(event.password);
          yield PaperBackup(account: account, phrase: phrase, error: false);
          navigator.add(PushNamed('/secret_backup'));
        }
      } catch (e) {
        yield Locked(error: true);
      }
    }
    if (event is SetPaperBackup) {
      final paperBackup = state as PaperBackup;
      if (paperBackup.phrase.compareTo(event.phrase) == 0) {
        keystore.setPaperBackup();
        yield Unlocked(account: paperBackup.account);
        navigator.add(PushNamed('/account_details'));
      } else {
        yield PaperBackup(account: paperBackup.account, phrase: paperBackup.phrase, error: true);
      }
    }
    if (event is PostponeBackup) {
      final paperBackup = state as PaperBackup;
      yield Unlocked(account: paperBackup.account);
      navigator.add(PushNamed('/account_details'));
    }
  }
}
