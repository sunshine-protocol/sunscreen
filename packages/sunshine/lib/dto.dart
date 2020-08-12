// ignore_for_file: avoid_as

import 'dart:convert';
import 'dart:typed_data';
import 'package:cbor/cbor.dart' as cbor;
import 'package:typed_data/typed_data.dart';

class BountyInformation {
  BountyInformation({
    this.id,
    this.repoOwner,
    this.repoName,
    this.issueNumber,
    this.depositer,
    int total,
  }) : _total = total;

  factory BountyInformation.fromBytes(Uint8List bytes) {
    if (bytes == null) {
      return null;
    }
    final inst = cbor.Cbor();
    final payloadBuffer = Uint8Buffer()..addAll(bytes);
    inst.decodeFromBuffer(payloadBuffer);
    final data = jsonDecode(inst.decodedToJSON());
    return BountyInformation.fromJSON(data);
  }

  factory BountyInformation.fromJSON(dynamic data) {
    return BountyInformation(
      id: data['id'] as int,
      repoOwner: data['repo_owner'] as String,
      repoName: data['repo_name'] as String,
      issueNumber: data['issue_number'] as int,
      depositer: data['depositer'] as String,
      total: data['total'] as int,
    );
  }
  final int id;
  final String repoOwner;
  final String repoName;
  final int issueNumber;
  final String depositer;
  int _total;
  int get total => _total;

  static List<BountyInformation> buildList(Uint8List bytes) {
    if (bytes == null) {
      return [];
    }
    final inst = cbor.Cbor();
    final payloadBuffer = Uint8Buffer()..addAll(bytes);
    inst.decodeFromBuffer(payloadBuffer);
    final data = jsonDecode(inst.decodedToJSON()) as List<dynamic>;
    return data.map((e) => BountyInformation.fromJSON(e)).toList();
  }

  int contibute(int amount) {
    return _total += amount;
  }
}

class BountySubmissionInformation {
  BountySubmissionInformation({
    this.id,
    this.repoOwner,
    this.repoName,
    this.issueNumber,
    this.bountyId,
    this.submitter,
    this.amount,
    this.awaitingReview,
    this.approved,
  });

  factory BountySubmissionInformation.fromBytes(Uint8List bytes) {
    if (bytes == null) {
      return null;
    }
    final inst = cbor.Cbor();
    final payloadBuffer = Uint8Buffer()..addAll(bytes);
    inst.decodeFromBuffer(payloadBuffer);
    final data = jsonDecode(inst.decodedToJSON());
    return BountySubmissionInformation.fromJSON(data);
  }

  factory BountySubmissionInformation.fromJSON(dynamic data) {
    return BountySubmissionInformation(
      id: data['id'] as int,
      repoOwner: data['repo_owner'] as String,
      repoName: data['repo_name'] as String,
      issueNumber: data['issue_number'] as int,
      bountyId: data['bounty_id'] as int,
      submitter: data['submitter'] as String,
      amount: data['amount'] as int,
      awaitingReview: data['awaiting_review'] as bool,
      approved: data['approved'] as bool,
    );
  }
  final int id;
  final String repoOwner;
  final String repoName;
  final int issueNumber;
  final int bountyId;
  final String submitter;
  final int amount;
  final bool awaitingReview;
  final bool approved;

  static List<BountySubmissionInformation> buildList(Uint8List bytes) {
    if (bytes == null) {
      return [];
    }
    final inst = cbor.Cbor();
    final payloadBuffer = Uint8Buffer()..addAll(bytes);
    inst.decodeFromBuffer(payloadBuffer);
    final data = jsonDecode(inst.decodedToJSON()) as List<dynamic> ?? [];
    return data.map((e) => BountySubmissionInformation.fromJSON(e)).toList();
  }
}
