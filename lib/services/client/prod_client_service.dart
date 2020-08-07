import 'package:sunshine/sunshine.dart';
import 'package:injectable/injectable.dart';
import 'package:sunshine_ffi/dto.dart';

import 'client_service.dart';
import 'sunshine_client_service.dart';

@prod
@LazySingleton(as: ClientService)
class ProdClientService implements ClientService {
  ProdClientService({SunshineClientService sunshineClientService})
      : _sunshineClientService = sunshineClientService;
  final SunshineClientService _sunshineClientService;

  @override
  Future<bool> get ready => _sunshineClientService.ready;

  @override
  Future<bool> lock() {
    return _sunshineClientService.lockKey();
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    return _sunshineClientService.setKey(
      password,
      suri: suri,
      paperKey: paperKey,
    );
  }

  @override
  Future<bool> unlock(String password) {
    return _sunshineClientService.unlockKey(password);
  }

  @override
  Future<String> balance() async {
    return _sunshineClientService
        .balance(await uid())
        .then((value) => value.toString());
  }

  @override
  Future<String> transfer(String id, int amount) {
    return _sunshineClientService.transfer(id, amount);
  }

  @override
  Future<String> uid() async {
    throw UnimplementedError();
  }

  @override
  Future<int> mint() {
    return _sunshineClientService.mint();
  }

  @override
  Future<bool> hasKey() {
    return _sunshineClientService.hasKey();
  }

  @override
  Future<String> approveBounty(int submissionId) {
    return _sunshineClientService.approveBounty(submissionId);
  }

  @override
  Future<String> contibuteToBounty(int bountyId, int amount) {
    return _sunshineClientService.contibuteToBounty(bountyId, amount);
  }

  @override
  Future<BountyInformation> getBounty(int bountyId) {
    return _sunshineClientService.getBounty(bountyId);
  }

  @override
  Future<BountySubmissionInformation> getSubmission(int submissionId) {
    return _sunshineClientService.getSubmission(submissionId);
  }

  @override
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    int bountyId,
  ) {
    return _sunshineClientService.listBountySubmissions(bountyId);
  }

  @override
  Future<List<BountyInformation>> listOpenBounties(int min) {
    return _sunshineClientService.listOpenBounties(min);
  }

  @override
  Future<int> postBounty(
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    return _sunshineClientService.postBounty(
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }

  @override
  Future<int> submitForBounty(
    int bountyId,
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    return _sunshineClientService.submitForBounty(
      bountyId,
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }
}
