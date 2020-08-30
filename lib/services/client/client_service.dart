import 'package:sunshine/models/models.dart';
import 'package:sunshine_ffi/dto.dart';

abstract class ClientService {
  Future<bool> get ready;
  Future<bool> lock();
  Future<bool> unlock(String password);
  Future<String> setKey(String password, {String suri, String paperKey});
  Future<String> uid();
  Future<bool> hasKey();
  Future<String> balance();
  Future<String> transfer(String id, BigInt amount);
  Future<BigInt> mint();
  Future<BountyInformation> getBounty(BigInt bountyId);
  Future<BountySubmissionInformation> getSubmission(BigInt submissionId);
  Future<List<BountyInformation>> listOpenBounties(BigInt min);
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    BigInt bountyId,
  );
  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  );
  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  );
  Future<String> approveBounty(BigInt submissionId);
  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount);
  Future<String> deviceId();
  Future<bool> revokeDevice(String id);
  Future<bool> addDevice(String id);
  Future<List<String>> devices();
  Future<String> addPaperKey();
  Future<List<String>> identities(String uid);
  Future<String> uidOf(String id);
  Future<ProveIdentityResult> proveIdentity(SocialIdentityService service);
  Future<bool> revokeIdentity(SocialIdentityService service);
}

class ProveIdentityResult {
  const ProveIdentityResult(this.instructions, this.proof);
  final String instructions;
  final String proof;
}
