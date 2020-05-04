// AUTOMATICALLY GENERATED. DO NOT EDIT.

import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart' as ffi;

ffi.DynamicLibrary load({String basePath = ''}) {
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('${basePath}libkeystore_ffi.so');
  } else if (Platform.isIOS) {
    return ffi.DynamicLibrary.process();
  } else if (Platform.isMacOS) {
    return ffi.DynamicLibrary.open('${basePath}libkeystore_ffi.dylib');
  } else if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('${basePath}libkeystore_ffi.dll');
  } else {
    throw NotSupportedPlatform('${Platform.operatingSystem} is not supported!');
  }
}

class NotSupportedPlatform implements Exception {
  NotSupportedPlatform(String s);
}

ffi.DynamicLibrary dynamicLibrary() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return load(basePath: '../../../target/debug/');
  } else {
    return load();
  }
}

/// Dynamic library
final _dynamicLibrary = dynamicLibrary();

/// C function `last_error_length`.
int last_error_length() {
  return _last_error_length();
}

final _last_error_length_Dart _last_error_length = _dynamicLibrary
    .lookupFunction<_last_error_length_C, _last_error_length_Dart>(
  'last_error_length',
);
typedef _last_error_length_C = ffi.Int32 Function();
typedef _last_error_length_Dart = int Function();

/// C function `error_message_utf8`.
int error_message_utf8(
  ffi.Pointer<ffi.Utf8> arg0,
  int arg1,
) {
  return _error_message_utf8(arg0, arg1);
}

final _error_message_utf8_Dart _error_message_utf8 = _dynamicLibrary
    .lookupFunction<_error_message_utf8_C, _error_message_utf8_Dart>(
  'error_message_utf8',
);
typedef _error_message_utf8_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Utf8> arg0,
  ffi.Int32 arg1,
);
typedef _error_message_utf8_Dart = int Function(
  ffi.Pointer<ffi.Utf8> arg0,
  int arg1,
);

/// C function `keystore_new`.
ffi.Pointer keystore_new() {
  return _keystore_new();
}

final _keystore_new_Dart _keystore_new =
    _dynamicLibrary.lookupFunction<_keystore_new_C, _keystore_new_Dart>(
  'keystore_new',
);
typedef _keystore_new_C = ffi.Pointer Function();
typedef _keystore_new_Dart = ffi.Pointer Function();

/// C function `keystore_from_keyfile`.
ffi.Pointer keystore_from_keyfile(
  ffi.Pointer<ffi.Utf8> arg0,
) {
  return _keystore_from_keyfile(arg0);
}

final _keystore_from_keyfile_Dart _keystore_from_keyfile = _dynamicLibrary
    .lookupFunction<_keystore_from_keyfile_C, _keystore_from_keyfile_Dart>(
  'keystore_from_keyfile',
);
typedef _keystore_from_keyfile_C = ffi.Pointer Function(
  ffi.Pointer<ffi.Utf8> arg0,
);
typedef _keystore_from_keyfile_Dart = ffi.Pointer Function(
  ffi.Pointer<ffi.Utf8> arg0,
);

/// C function `keystore_destroy`.
void keystore_destroy(
  ffi.Pointer arg0,
) {
  _keystore_destroy(arg0);
}

final _keystore_destroy_Dart _keystore_destroy =
    _dynamicLibrary.lookupFunction<_keystore_destroy_C, _keystore_destroy_Dart>(
  'keystore_destroy',
);
typedef _keystore_destroy_C = ffi.Void Function(
  ffi.Pointer arg0,
);
typedef _keystore_destroy_Dart = void Function(
  ffi.Pointer arg0,
);

/// C function `keystore_status`.
int keystore_status(
  ffi.Pointer arg0,
) {
  return _keystore_status(arg0);
}

final _keystore_status_Dart _keystore_status =
    _dynamicLibrary.lookupFunction<_keystore_status_C, _keystore_status_Dart>(
  'keystore_status',
);
typedef _keystore_status_C = ffi.Int32 Function(
  ffi.Pointer arg0,
);
typedef _keystore_status_Dart = int Function(
  ffi.Pointer arg0,
);

/// C function `keystore_generate`.
int keystore_generate(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
) {
  return _keystore_generate(arg0, arg1);
}

final _keystore_generate_Dart _keystore_generate = _dynamicLibrary
    .lookupFunction<_keystore_generate_C, _keystore_generate_Dart>(
  'keystore_generate',
);
typedef _keystore_generate_C = ffi.Int32 Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);
typedef _keystore_generate_Dart = int Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);

/// C function `keystore_import`.
int keystore_import(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
  ffi.Pointer<ffi.Utf8> arg2,
) {
  return _keystore_import(arg0, arg1, arg2);
}

final _keystore_import_Dart _keystore_import =
    _dynamicLibrary.lookupFunction<_keystore_import_C, _keystore_import_Dart>(
  'keystore_import',
);
typedef _keystore_import_C = ffi.Int32 Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
  ffi.Pointer<ffi.Utf8> arg2,
);
typedef _keystore_import_Dart = int Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
  ffi.Pointer<ffi.Utf8> arg2,
);

/// C function `keystore_unlock`.
int keystore_unlock(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
) {
  return _keystore_unlock(arg0, arg1);
}

final _keystore_unlock_Dart _keystore_unlock =
    _dynamicLibrary.lookupFunction<_keystore_unlock_C, _keystore_unlock_Dart>(
  'keystore_unlock',
);
typedef _keystore_unlock_C = ffi.Int32 Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);
typedef _keystore_unlock_Dart = int Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);

/// C function `keystore_lock`.
int keystore_lock(
  ffi.Pointer arg0,
) {
  return _keystore_lock(arg0);
}

final _keystore_lock_Dart _keystore_lock =
    _dynamicLibrary.lookupFunction<_keystore_lock_C, _keystore_lock_Dart>(
  'keystore_lock',
);
typedef _keystore_lock_C = ffi.Int32 Function(
  ffi.Pointer arg0,
);
typedef _keystore_lock_Dart = int Function(
  ffi.Pointer arg0,
);

/// C function `keystore_paper_backup`.
int keystore_paper_backup(
  ffi.Pointer arg0,
) {
  return _keystore_paper_backup(arg0);
}

final _keystore_paper_backup_Dart _keystore_paper_backup = _dynamicLibrary
    .lookupFunction<_keystore_paper_backup_C, _keystore_paper_backup_Dart>(
  'keystore_paper_backup',
);
typedef _keystore_paper_backup_C = ffi.Int32 Function(
  ffi.Pointer arg0,
);
typedef _keystore_paper_backup_Dart = int Function(
  ffi.Pointer arg0,
);

/// C function `keystore_set_paper_backup`.
int keystore_set_paper_backup(
  ffi.Pointer arg0,
) {
  return _keystore_set_paper_backup(arg0);
}

final _keystore_set_paper_backup_Dart _keystore_set_paper_backup =
    _dynamicLibrary.lookupFunction<_keystore_set_paper_backup_C,
        _keystore_set_paper_backup_Dart>(
  'keystore_set_paper_backup',
);
typedef _keystore_set_paper_backup_C = ffi.Int32 Function(
  ffi.Pointer arg0,
);
typedef _keystore_set_paper_backup_Dart = int Function(
  ffi.Pointer arg0,
);

/// C function `keystore_phrase`.
ffi.Pointer<ffi.Utf8> keystore_phrase(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
) {
  return _keystore_phrase(arg0, arg1);
}

final _keystore_phrase_Dart _keystore_phrase =
    _dynamicLibrary.lookupFunction<_keystore_phrase_C, _keystore_phrase_Dart>(
  'keystore_phrase',
);
typedef _keystore_phrase_C = ffi.Pointer<ffi.Utf8> Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);
typedef _keystore_phrase_Dart = ffi.Pointer<ffi.Utf8> Function(
  ffi.Pointer arg0,
  ffi.Pointer<ffi.Utf8> arg1,
);

/// C function `phrase_destroy`.
void phrase_destroy(
  ffi.Pointer<ffi.Utf8> arg0,
) {
  _phrase_destroy(arg0);
}

final _phrase_destroy_Dart _phrase_destroy =
    _dynamicLibrary.lookupFunction<_phrase_destroy_C, _phrase_destroy_Dart>(
  'phrase_destroy',
);
typedef _phrase_destroy_C = ffi.Void Function(
  ffi.Pointer<ffi.Utf8> arg0,
);
typedef _phrase_destroy_Dart = void Function(
  ffi.Pointer<ffi.Utf8> arg0,
);

/// C function `keystore_account`.
ffi.Pointer<AccountStruct> keystore_account(
  ffi.Pointer arg0,
) {
  return _keystore_account(arg0);
}

final _keystore_account_Dart _keystore_account =
    _dynamicLibrary.lookupFunction<_keystore_account_C, _keystore_account_Dart>(
  'keystore_account',
);
typedef _keystore_account_C = ffi.Pointer<AccountStruct> Function(
  ffi.Pointer arg0,
);
typedef _keystore_account_Dart = ffi.Pointer<AccountStruct> Function(
  ffi.Pointer arg0,
);

/// C function `account_destroy`.
void account_destroy(
  ffi.Pointer<AccountStruct> arg0,
) {
  _account_destroy(arg0);
}

final _account_destroy_Dart _account_destroy =
    _dynamicLibrary.lookupFunction<_account_destroy_C, _account_destroy_Dart>(
  'account_destroy',
);
typedef _account_destroy_C = ffi.Void Function(
  ffi.Pointer<AccountStruct> arg0,
);
typedef _account_destroy_Dart = void Function(
  ffi.Pointer<AccountStruct> arg0,
);

/// C struct `AccountStruct`.
class AccountStruct extends ffi.Struct {
  //@ffi.Pointer()
  ffi.Pointer<ffi.Utf8> name;

  //@ffi.Pointer()
  ffi.Pointer<ffi.Utf8> ss58;

  //@ffi.Pointer()
  ffi.Pointer<ffi.Uint8> identicon_ptr;

  @ffi.Int32()
  int identicon_len;

  //@ffi.Pointer()
  ffi.Pointer<ffi.Uint8> qrcode_ptr;

  @ffi.Int32()
  int qrcode_len;

  static ffi.Pointer<AccountStruct> allocate() {
    return ffi.allocate<AccountStruct>();
  }
}
