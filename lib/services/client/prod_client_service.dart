import 'package:sunshine/models/models.dart';
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
  Future<String> deviceId() async {
    return _sunshineClientService.currentDevice();
  }

  @override
  Future<String> addPaperKey() {
    return _sunshineClientService.addPaperKey();
  }

  @override
  Future<bool> addDevice(String id) {
    return _sunshineClientService.addDevice(id);
  }

  @override
  Future<List<String>> identities(String uid) async {
    return _sunshineClientService.listIdentities(uid);
  }

  @override
  Future<ProveIdentityResult> proveIdentity(
      SocialIdentityService service) async {
    final result = await _sunshineClientService.proveIdentity(service.display);
    return ProveIdentityResult(result[0], result[1]);
  }

  @override
  Future<List<String>> devices() async {
    return _sunshineClientService.listDevices(await uid());
  }

  @override
  Future<bool> revokeDevice(String id) {
    return _sunshineClientService.removeDevice(id);
  }

  @override
  Future<bool> revokeIdentity(SocialIdentityService service) {
    return _sunshineClientService.revokeIdentity(service.display);
  }

  @override
  Future<String> uidOf(String id) {
    return _sunshineClientService.resolveUid(id);
  }

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
        .balance(null)
        .then((value) => value.toString());
  }

  @override
  Future<String> transfer(String id, BigInt amount) {
    return _sunshineClientService.transfer(id, amount);
  }

  @override
  Future<String> uid() async {
    return _sunshineClientService.resolveUid(await deviceId());
  }

  @override
  Future<BigInt> mint() {
    return _sunshineClientService.mint();
  }

  @override
  Future<bool> hasKey() {
    return _sunshineClientService.hasKey();
  }

  @override
  Future<String> approveBounty(BigInt submissionId) {
    return _sunshineClientService.approveBounty(submissionId);
  }

  @override
  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount) {
    return _sunshineClientService.contibuteToBounty(bountyId, amount);
  }

  @override
  Future<BountyInformation> getBounty(BigInt bountyId) {
    return _sunshineClientService.getBounty(bountyId);
  }

  @override
  Future<BountySubmissionInformation> getSubmission(BigInt submissionId) {
    return _sunshineClientService.getSubmission(submissionId);
  }

  @override
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    BigInt bountyId,
  ) async {
    final list = await _sunshineClientService.listBountySubmissions(bountyId);
    print('Bounty $bountyId Submissions: $list');
    return list;
  }

  @override
  Future<List<BountyInformation>> listOpenBounties(BigInt min) async {
    final list = await _sunshineClientService.listOpenBounties(min);
    print('Open Bounties: $list');
    return list;
  }

  @override
  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) async {
    final id = await _sunshineClientService.postBounty(
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
    return id;
  }

  @override
  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
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
