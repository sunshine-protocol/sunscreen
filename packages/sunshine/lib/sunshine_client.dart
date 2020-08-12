import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:isolate/ports.dart';
import 'package:frusty_logger/frusty_logger.dart';
import 'package:sunshine_ffi/dto.dart';

import 'constants.dart' as ffi;
import 'ffi.dart' as ffi;

class SunshineClient {
  SunshineClient({@required Directory root, @required Uri chainspecPath})
      : _root = root,
        _chainspecPath = chainspecPath {
    ffi.store_dart_post_cobject(NativeApi.postCObject);
    FrustyLogger.init(ffi.dl);
    FrustyLogger.addListener(print);
  }

  final Directory _root;
  final Uri _chainspecPath;
  bool _started = false;

  Future<bool> get ready => startUpClient();
  Future<bool> startUpClient() async {
    // to avoid any other calls
    if (_started) {
      return true;
    }
    final path = Utf8.toUtf8(_root.path);
    final chainspecPath = Utf8.toUtf8(await _getChainspecPath());
    final completer = Completer<int>();
    final port = singleCompletePort(completer);
    final result = ffi.client_init(port.nativePort, path, chainspecPath);
    if (result == ffi.ok) {
      return _clientInitOkay(completer.future);
    } else if (result == ffi.alreadyInit) {
      return true;
    } else {
      throw StateError('Status Code: $result');
    }
  }

  Future<bool> hasKey() {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final result = ffi.client_key_exists(port.nativePort);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<String> uid() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final result = ffi.client_key_uid(port.nativePort);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<bool> lockKey() {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final result = ffi.client_key_lock(port.nativePort);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<bool> unlockKey(String password) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    final pass = Utf8.toUtf8(password);
    final result = ffi.client_key_unlock(port.nativePort, pass);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<String> setKey(String password, {String suri, String paperKey}) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final s = suri != null ? Utf8.toUtf8(suri) : nullptr;
    final pass = Utf8.toUtf8(password);
    final phrase = paperKey != null ? Utf8.toUtf8(paperKey) : nullptr;
    final result = ffi.client_key_set(port.nativePort, pass, s, phrase);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<int> balance(String identifier) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = identifier != null ? Utf8.toUtf8(identifier) : nullptr;
    final result = ffi.client_wallet_balance(port.nativePort, id);
    assert(result == ffi.ok);
    return completer.future.then(int.parse);
  }

  Future<String> transfer(String identifier, int amount) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = Utf8.toUtf8(identifier);
    final result = ffi.client_wallet_transfer(port.nativePort, id, amount);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<int> mint() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final result = ffi.client_faucet_mint(port.nativePort);
    assert(result == ffi.ok);
    return completer.future.then(int.parse);
  }

  Future<BountyInformation> getBounty(int bountyId) {
    final completer = Completer<Uint8List>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_get(port.nativePort, bountyId);
    assert(result == ffi.ok);
    return completer.future.then((bytes) => BountyInformation.fromBytes(bytes));
  }

  Future<BountySubmissionInformation> getSubmission(int submissionId) {
    final completer = Completer<Uint8List>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_get_submission(
      port.nativePort,
      submissionId,
    );
    assert(result == ffi.ok);
    return completer.future.then(
      (bytes) => BountySubmissionInformation.fromBytes(bytes),
    );
  }

  Future<List<BountyInformation>> listOpenBounties(int min) {
    final completer = Completer<Uint8List>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_open_bounties(
      port.nativePort,
      min,
    );
    assert(result == ffi.ok);
    return completer.future.then(BountyInformation.buildList);
  }

  Future<List<BountySubmissionInformation>> listBountySubmissions(
    int bountyId,
  ) {
    final completer = Completer<Uint8List>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_open_bounty_submissions(
      port.nativePort,
      bountyId,
    );
    assert(result == ffi.ok);
    return completer.future.then(BountySubmissionInformation.buildList);
  }

  Future<int> postBounty(
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    final completer = Completer<int>();
    final port = singleCompletePort(completer);
    final owner = Utf8.toUtf8(repoOwner);
    final name = Utf8.toUtf8(repoName);
    final result = ffi.client_bounty_post(
      port.nativePort,
      owner,
      name,
      issueNumber,
      amount,
    );
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<int> submitForBounty(
    int bountyId,
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    final completer = Completer<int>();
    final port = singleCompletePort(completer);
    final owner = Utf8.toUtf8(repoOwner);
    final name = Utf8.toUtf8(repoName);
    final result = ffi.client_bounty_submit(
      port.nativePort,
      bountyId,
      owner,
      name,
      issueNumber,
      amount,
    );
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<String> approveBounty(int submissionId) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_approve(port.nativePort, submissionId);
    assert(result == ffi.ok);
    return completer.future;
  }

  Future<String> contibuteToBounty(int bountyId, int amount) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final result = ffi.client_bounty_contribute(
      port.nativePort,
      bountyId,
      amount,
    );
    assert(result == ffi.ok);
    return completer.future;
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
}
