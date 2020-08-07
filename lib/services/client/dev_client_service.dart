import 'package:injectable/injectable.dart';
import 'package:sunshine_ffi/dto.dart';

import 'client_service.dart';

@dev
@LazySingleton(as: ClientService)
class DevClientService implements ClientService {
  String _uid;
  String _balance;
  String _password;

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
  Future<String> transfer(String id, int amount) {
    throw UnimplementedError();
  }

  @override
  Future<String> uid() async {
    return _uid;
  }

  @override
  Future<int> mint() async {
    _balance = (int.parse(_balance) + 1000000).toString();
    return 1000000;
  }

  @override
  Future<String> approveBounty(int submissionId) async {
    return '1000';
  }

  @override
  Future<String> contibuteToBounty(int bountyId, int amount) async {
    final bounty = await getBounty(bountyId);
    return bounty?.contibute(amount).toString() ?? '0';
  }

  @override
  Future<BountyInformation> getBounty(int bountyId) async {
    return _mockedBounties.firstWhere(
      (e) => e.id == bountyId,
      orElse: () => null,
    );
  }

  @override
  Future<BountySubmissionInformation> getSubmission(int submissionId) async {
    return _mockedSubmissions.firstWhere(
      (e) => e.id == submissionId,
      orElse: () => null,
    );
  }

  @override
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    int bountyId,
  ) async {
    return _mockedSubmissions.where((e) => e.bountyId == bountyId).toList();
  }

  @override
  Future<List<BountyInformation>> listOpenBounties(int min) async {
    return _mockedBounties.where((e) => e.total >= min).toList();
  }

  @override
  Future<int> postBounty(
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) async {
    final last = _mockedBounties.last;
    final v = BountyInformation(
      depositer: await uid(),
      id: last.id + 1,
      issueNumber: issueNumber,
      repoName: repoName,
      repoOwner: repoOwner,
      total: amount,
    );
    _mockedBounties.add(v);
    return v.id;
  }

  @override
  Future<int> submitForBounty(
    int bountyId,
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) async {
    final last = _mockedBounties.last;
    final v = BountySubmissionInformation(
      id: last.id + 1,
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

final List<BountyInformation> _mockedBounties = [];
final List<BountySubmissionInformation> _mockedSubmissions = [];
