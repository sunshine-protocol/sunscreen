import 'dart:io' show File;
import 'package:flutter_test/flutter_test.dart';
import 'package:keystore/keystore.dart';

void cleanup(String path) {
  final keyfile = File(path);
  if (keyfile.existsSync()) {
    keyfile.deleteSync();
  }
}

void main() {
  final keyfile = '/tmp/keyfile';
  final phrase =
      'nice river damage grief denial there review skill there shed blouse found remain pilot brand';

  group('Keystore', () {
    test('creates a new keystore', () {
      final keystore = Keystore();
      keystore.dispose();
    });
    test('generates a key', () {
      cleanup(keyfile);
      final keystore = Keystore.fromKeyfile(keyfile);
      expect(keystore.status(), equals(Status.uninitialized));
      keystore.generate('password');
      expect(keystore.status(), equals(Status.unlocked));
      keystore.lock();
      expect(keystore.status(), equals(Status.locked));
      keystore.unlock('password');
      expect(keystore.status(), equals(Status.unlocked));
      keystore.dispose();
    });
    test('imports a key', () {
      cleanup(keyfile);
      final keystore = Keystore.fromKeyfile(keyfile);
      expect(keystore.status(), equals(Status.uninitialized));
      keystore.import(phrase, 'password');
      expect(keystore.status(), equals(Status.unlocked));
      keystore.lock();
      expect(keystore.status(), equals(Status.locked));
      keystore.unlock('password');
      expect(keystore.status(), equals(Status.unlocked));
      final phrase2 = keystore.phrase('password');
      expect(phrase, equals(phrase2));
      keystore.dispose();
    });
    test('unlock error', () {
      cleanup(keyfile);
      final keystore = Keystore.fromKeyfile(keyfile);
      keystore.generate('password');
      keystore.lock();
      try {
        keystore.unlock('typo');
      } catch (e) {
        return;
      }
      throw 'unlock succeeded';
    });
    test('paper backup', () {
      cleanup(keyfile);
      final keystore = Keystore.fromKeyfile(keyfile);
      keystore.generate('password');
      expect(keystore.paperBackup(), equals(false));
      keystore.setPaperBackup();
      expect(keystore.paperBackup(), equals(true));
    });
    test('account details', () {
      cleanup(keyfile);
      final keystore = Keystore.fromKeyfile(keyfile);
      keystore.generate('password');
      final account = keystore.account();
      expect(account.name, equals("/"));
      print(account.ss58);
      print(account.identicon.length);
      print(account.qrcode.length);
    });
  });
}
