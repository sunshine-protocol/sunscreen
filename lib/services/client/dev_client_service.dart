import 'package:injectable/injectable.dart';
import 'package:sunshine_ffi/dto.dart';

import 'client_service.dart';

@dev
@LazySingleton(as: ClientService)
class DevClientService implements ClientService {
  String _uid = '1';
  String _balance = '1000000';
  String _password = '12345678';

  @override
  Future<bool> hasKey() async {
    return _uid != null;
  }

  @override
  Future<bool> get ready => Future.delayed(
        const Duration(seconds: 2),
        () => true,
      );

  @override
  Future<bool> lock() async {
    return true;
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    _password = password;
    _uid = '1';
    _balance = '0';
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return _uid;
  }

  @override
  Future<bool> unlock(String password) async {
    if (password == _password) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> balance() async {
    return _balance ?? '100000000';
  }

  @override
  Future<String> transfer(String id, BigInt amount) {
    throw UnimplementedError();
  }

  @override
  Future<String> uid() async {
    return _uid;
  }

  @override
  Future<BigInt> mint() async {
    _balance = (int.parse(_balance) + 1000000).toString();
    return BigInt.from(1000000);
  }

  @override
  Future<String> approveBounty(BigInt submissionId) async {
    return '1000';
  }

  @override
  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount) async {
    final bounty = await getBounty(bountyId);
    return bounty?.contibute(amount).toString() ?? '0';
  }

  @override
  Future<BountyInformation> getBounty(BigInt bountyId) async {
    return _mockedBounties.firstWhere(
      (e) => e.id == bountyId,
      orElse: () => null,
    );
  }

  @override
  Future<BountySubmissionInformation> getSubmission(BigInt submissionId) async {
    return _mockedSubmissions.firstWhere(
      (e) => e.id == submissionId,
      orElse: () => null,
    );
  }

  @override
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    BigInt bountyId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return _mockedSubmissions.where((e) => e.bountyId == bountyId).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<List<BountyInformation>> listOpenBounties(BigInt min) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return _mockedBounties.where((e) => e.total >= min).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) async {
    final last = _mockedBounties.last;
    final v = BountyInformation(
      depositer: await uid(),
      id: last.id + BigInt.from(1),
      issueNumber: issueNumber,
      repoName: repoName,
      repoOwner: repoOwner,
      total: amount,
    );
    _mockedBounties.add(v);
    return v.id;
  }

  @override
  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) async {
    final last = _mockedSubmissions.last;
    final v = BountySubmissionInformation(
      id: last.id,
      bountyId: bountyId,
      issueNumber: issueNumber,
      repoName: repoName,
      repoOwner: repoOwner,
      amount: amount,
      approved: false,
      awaitingReview: true,
      submitter: await uid(),
    );
    _mockedSubmissions.add(v);
    return v.id;
  }
}

final List<BountyInformation> _mockedBounties = [
  BountyInformation(
    id: BigInt.from(1),
    depositer: '1',
    total: BigInt.from(5595),
    repoOwner: 'bluzelle',
    repoName: 'swarm-of-duty',
    issueNumber: BigInt.from(2),
  ),
  BountyInformation(
    id: BigInt.from(2),
    depositer: '1',
    total: BigInt.from(22288),
    repoOwner: 'aragonone',
    repoName: 'hack-for-freedom',
    issueNumber: BigInt.from(7),
  ),
  BountyInformation(
    id: BigInt.from(3),
    depositer: '1',
    total: BigInt.from(100000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(29),
  ),
  BountyInformation(
    id: BigInt.from(4),
    depositer: '1',
    total: BigInt.from(15000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(30),
  ),
];
final List<BountySubmissionInformation> _mockedSubmissions = [
  BountySubmissionInformation(
    id: BigInt.from(1),
    bountyId: BigInt.from(1),
    approved: false,
    awaitingReview: true,
    submitter: '1',
    amount: BigInt.from(6000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(29),
  ),
  BountySubmissionInformation(
    id: BigInt.from(2),
    bountyId: BigInt.from(1),
    approved: false,
    awaitingReview: true,
    submitter: '3',
    amount: BigInt.from(6000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(30),
  ),
];
