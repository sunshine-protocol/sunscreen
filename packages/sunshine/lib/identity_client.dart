import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:isolate/ports.dart';
import 'package:frusty_logger/frusty_logger.dart';

import 'constants.dart' as ffi;
import 'ffi.dart' as ffi;

class IdentityClient {
  IdentityClient({@required Directory root, @required Uri chainspecPath})
      : _root = root,
        _chainspecPath = chainspecPath {
    ffi.store_dart_post_cobject(NativeApi.postCObject);
    FrustyLogger.init(ffi.dl);
  }

  Future<bool> get ready => startUpClient();

  final Directory _root;
  final Uri _chainspecPath;
  bool _started = false;

  Future<bool> startUpClient() async {
    // to avoid any other calls
    if (_started) {
      return true;
    }
    final path = Utf8.toUtf8(_root.path);
    final chainspecPath = Utf8.toUtf8(await _getChainspecPath());
    final completer = Completer<int>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_init(port.nativePort, path, chainspecPath);
    final result = ffi.ok;
    if (result == ffi.ok) {
      return _clientInitOkay(completer.future);
    } else if (result == ffi.alreadyInit) {
      return true;
    } else {
      throw StateError('Status Code: $result');
    }
  }

  Future<bool> lockKey() {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_key_lock(port.nativePort);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<bool> unlockKey(String password) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final pass = Utf8.toUtf8(password);
    // final result = ffi.client_key_unlock(port.nativePort, pass);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<String> setKey(String password, {String suri, String paperKey}) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final s = suri != null ? Utf8.toUtf8(suri) : nullptr;
    final pass = Utf8.toUtf8(password);
    final phrase = paperKey != null ? Utf8.toUtf8(paperKey) : nullptr;
    // final result = ffi.client_key_set(port.nativePort, pass, s, phrase);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<String> currentDevice() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_device_current(port.nativePort);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<bool> hasDeviceKey() {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_device_has_key(port.nativePort);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<bool> addDevice(String deviceId) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(deviceId);
    // final result = ffi.client_device_add(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<bool> removeDevice(String deviceId) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(deviceId);
    // final result = ffi.client_device_remove(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<List<String>> listDevices(String identifier) {
    final completer = Completer<List<dynamic>>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(identifier);
    // final result = ffi.client_device_list(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future).then((value) {
      return value.map((e) => e.toString()).toList();
    });
  }

  Future<String> addPaperKey() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_device_paperkey(port.nativePort);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<List<String>> listIdentities(String uid) {
    final completer = Completer<List<dynamic>>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(uid);
    // final result = ffi.client_id_list(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future).then((value) {
      return value.map((e) => e.toString()).toList();
    });
  }

  Future<String> resolveUid(String identifier) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(identifier);
    // final result = ffi.client_id_resolve(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<List<String>> proveIdentity(String service) {
    final completer = Completer<List<dynamic>>();
    final port = singleCompletePort(completer);
    final s = Utf8.toUtf8(service);
    // final result = ffi.client_id_prove(port.nativePort, s);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future).then((value) {
      return value.map((e) => e.toString()).toList();
    });
  }

  Future<bool> revokeIdentity(String service) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final s = Utf8.toUtf8(service);
    // final result = ffi.client_id_revoke(port.nativePort, s);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<int> balance(String identifier) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(identifier);
    // final result = ffi.client_wallet_balance(port.nativePort, id);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future).then(int.parse);
  }

  Future<String> transfer(String identifier, int amount) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(identifier);
    // final result = ffi.client_wallet_transfer(port.nativePort, id, amount);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future);
  }

  Future<int> mint() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    // final result = ffi.client_faucet_mint(port.nativePort);
    final result = ffi.ok;
    assert(result == ffi.ok);
    return _ok(completer.future).then(int.parse);
  }

  Future<bool> _clientInitOkay(FutureOr<int> f) async {
    final start = DateTime.now();
    final res = await f;
    final end = DateTime.now();
    final elapsed = end.difference(start);
    print(
      'Client Started in:\n'
      '\t=> ${elapsed.inMinutes} min\n'
      '\t=> ${elapsed.inSeconds} sec\n',
    );
    _started = res == ffi.ok;
    return res == ffi.ok;
  }

  Future<String> _getChainspecPath() async {
    final path = '${_root.path}/chainspec.josn';
    final exists = File(path).existsSync();
    if (exists) {
      return path;
    } else {
      final bytes = await rootBundle.loadString(_chainspecPath.path);
      final f = await File(path).writeAsString(bytes, flush: true);
      return f.path;
    }
  }

  Future<T> _ok<T>(FutureOr<T> f) async {
    final val = await f;
    // check if there is an error by check if the value is null
    if (val == null) {
      // okay this maybe an error, lets read it
      // final e = ffi.client_last_error();
      final e = nullptr;
      if (e == nullptr) {
        // okay no error? that means it's okay to get a null from the ffi
        return null;
      } else {
        // it is a an error, get the utf8 value
        final message = Utf8.fromUtf8(e);
        throw StateError(message);
      }
    } else {
      // no errors, yay!
      return val;
    }
  }
}
