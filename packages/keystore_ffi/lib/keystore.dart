import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';
import './generated.dart';

enum Status {
  uninitialized,
  locked,
  unlocked,
}

class Keystore {
  Keystore() {
    _ptr = keystore_new();
  }

  Keystore.fromKeyfile(String path) {
    _ptr = keystore_from_keyfile(Utf8.toUtf8(path));
  }

  Pointer _ptr;

  Status status() {
    switch (keystore_status(_ptr)) {
      case 1:
        return Status.uninitialized;
      case 2:
        return Status.locked;
      case 3:
        return Status.unlocked;
      default:
        _throwError();
    }
  }

  void generate(String password) {
    if (keystore_generate(_ptr, Utf8.toUtf8(password)) != 1) {
      _throwError();
    }
  }

  void import(String phrase, String password) {
    if (keystore_import(_ptr, Utf8.toUtf8(phrase), Utf8.toUtf8(password)) !=
        1) {
      _throwError();
    }
  }

  void unlock(String password) {
    if (keystore_unlock(_ptr, Utf8.toUtf8(password)) != 1) {
      _throwError();
    }
  }

  void lock() {
    keystore_lock(_ptr);
  }

  bool paperBackup() {
    switch (keystore_paper_backup(_ptr)) {
      case 1:
        return true;
      case 2:
        return false;
      default:
        _throwError();
    }
  }

  void setPaperBackup() {
    if (keystore_set_paper_backup(_ptr) != 1) {
      _throwError();
    }
  }

  String phrase(String password) {
    final ptr = keystore_phrase(_ptr, Utf8.toUtf8(password));
    if (ptr == null) {
      _throwError();
    }
    final phrase = Utf8.fromUtf8(ptr).substring(0);
    phrase_destroy(ptr);
    return phrase;
  }

  Account account() {
    final ptr = keystore_account(_ptr);
    if (ptr == null) {
      _throwError();
    }
    final name = Utf8.fromUtf8(ptr.ref.name).substring(0);
    final ss58 = Utf8.fromUtf8(ptr.ref.ss58).substring(0);
    final identicon = ptr.ref.identicon_ptr.asTypedList(ptr.ref.identicon_len);
    final qrcode = ptr.ref.qrcode_ptr.asTypedList(ptr.ref.qrcode_len);
    final account =
        Account(name: name, ss58: ss58, identicon: identicon, qrcode: qrcode);
    account_destroy(ptr);
    return account;
  }

  void dispose() {
    keystore_destroy(_ptr);
  }

  void _throwError() {
    final length = last_error_length();
    final Pointer<Utf8> message = allocate(count: length);
    error_message_utf8(message, length);
    final error = Utf8.fromUtf8(message);
    print(error);
    throw error;
  }
}

class Account {
  Account({
    @required this.name,
    @required this.ss58,
    @required this.identicon,
    @required this.qrcode,
  });

  final String name;
  final String ss58;
  final Uint8List identicon;
  final Uint8List qrcode;
}
