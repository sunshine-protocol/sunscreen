import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:isolate/ports.dart';
import 'package:frusty_logger/frusty_logger.dart';
import 'package:sunshine_ffi/dto.dart';

import 'constants.dart' as ffi;
import 'ffi.dart' as ffi;

class SunshineClient {
  SunshineClient({
    @required Directory root,
    Uri chainspecPath,
    String url,
  })  : _root = root,
        _chainspecPath = chainspecPath,
        _url = url {
    ffi.store_dart_post_cobject(NativeApi.postCObject);
    FrustyLogger.init(ffi.dl);
  }

  final Directory _root;
  final Uri _chainspecPath;
  final String _url;
  bool _started = false;

  Future<bool> get ready => startUpClient();
  Future<bool> startUpClient() async {
    // to avoid any other calls
    if (_started) {
      return true;
    }
    FrustyLogger.addListener(print);
    final spec = _chainspecPath != null
        ? (await _getChainspecPath()).toUtf8Pointer()
        : nullptr;
    final rpcUrl = _url != null ? _url.toUtf8Pointer() : nullptr;
    final completer = Completer<int>();
    final port = singleCompletePort(completer);
    final result = ffi.client_init(
      port.nativePort,
      _root.path.toUtf8Pointer(),
      spec,
      rpcUrl,
    );
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
    ffi.client_key_exists(port.nativePort);
    return completer.future;
  }

  Future<String> uid() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_key_uid(port.nativePort);
    return completer.future;
  }

  Future<bool> lockKey() {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    ffi.client_key_lock(port.nativePort);
    return completer.future;
  }

  Future<bool> unlockKey(String password) {
    final completer = Completer<bool>();
    final port = singleCompletePort(completer);
    ffi.client_key_unlock(port.nativePort, password.toUtf8Pointer());
    return completer.future;
  }

  Future<String> setKey(String password, {String suri, String paperKey}) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final s = suri != null ? suri.toUtf8Pointer() : nullptr;
    final phrase = paperKey != null ? paperKey.toUtf8Pointer() : nullptr;
    ffi.client_key_set(port.nativePort, password.toUtf8Pointer(), s, phrase);
    return completer.future;
  }

  Future<BigInt> balance(String identifier) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    final id = identifier != null ? identifier.toUtf8Pointer() : nullptr;
    ffi.client_wallet_balance(port.nativePort, id);
    return completer.future.then(BigInt.parse);
  }

  Future<String> transfer(String identifier, BigInt amount) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_wallet_transfer(
      port.nativePort,
      identifier.toUtf8Pointer(),
      amount.toInt(),
    );
    return completer.future;
  }

  Future<BigInt> mint() {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_faucet_mint(port.nativePort);
    return completer.future.then(BigInt.parse);
  }

  Future<BountyInformation> getBounty(BigInt bountyId) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_get(port.nativePort, bountyId.toUtf8Pointer());
    return completer.future.then(
      (s) => BountyInformation.fromString(s),
    );
  }

  Future<BountySubmissionInformation> getSubmission(BigInt submissionId) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_get_submission(
      port.nativePort,
      submissionId.toUtf8Pointer(),
    );
    return completer.future.then(
      (s) => BountySubmissionInformation.fromString(s),
    );
  }

  Future<List<BountyInformation>> listOpenBounties(BigInt min) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_open_bounties(
      port.nativePort,
      min.toUtf8Pointer(),
    );
    return completer.future.then(BountyInformation.buildList);
  }

  Future<List<BountySubmissionInformation>> listBountySubmissions(
    BigInt bountyId,
  ) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_open_bounty_submissions(
      port.nativePort,
      bountyId.toUtf8Pointer(),
    );
    return completer.future.then(BountySubmissionInformation.buildList);
  }

  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) {
    final completer = Completer<BigInt>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_post(
      port.nativePort,
      repoOwner.toUtf8Pointer(),
      repoName.toUtf8Pointer(),
      issueNumber.toInt(),
      amount.toUtf8Pointer(),
    );
    return completer.future;
  }

  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) {
    print('Submit for bounty id: $bountyId');
    final completer = Completer<BigInt>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_submit(
      port.nativePort,
      bountyId.toUtf8Pointer(),
      repoOwner.toUtf8Pointer(),
      repoName.toUtf8Pointer(),
      issueNumber.toInt(),
      amount.toUtf8Pointer(),
    );
    return completer.future;
  }

  Future<String> approveBounty(BigInt submissionId) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_approve(port.nativePort, submissionId.toUtf8Pointer());
    return completer.future;
  }

  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount) {
    final completer = Completer<String>();
    final port = singleCompletePort(completer);
    ffi.client_bounty_contribute(
      port.nativePort,
      bountyId.toUtf8Pointer(),
      amount.toUtf8Pointer(),
    );
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

  // ignore: unused_element
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

extension BigIntUtf8Pointer on BigInt {
  Pointer<Utf8> toUtf8Pointer() {
    return Utf8.toUtf8(toString());
  }
}

extension StringUtf8Pointer on String {
  Pointer<Utf8> toUtf8Pointer() {
    return Utf8.toUtf8(this);
  }
}
