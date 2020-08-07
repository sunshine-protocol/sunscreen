import 'package:sunshine_ffi/dto.dart';

abstract class ClientService {
  Future<bool> get ready;
  Future<bool> lock();
  Future<bool> unlock(String password);
  Future<String> setKey(String password, {String suri, String paperKey});
  Future<String> uid();
  Future<bool> hasKey();
  Future<String> balance();
  Future<String> transfer(String id, int amount);
  Future<int> mint();
  Future<BountyInformation> getBounty(int bountyId);
  Future<BountySubmissionInformation> getSubmission(int submissionId);
  Future<List<BountyInformation>> listOpenBounties(int min);
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    int bountyId,
  );
  Future<int> postBounty(
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  );
  Future<int> submitForBounty(
    int bountyId,
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  );
  Future<String> approveBounty(int submissionId);
  Future<String> contibuteToBounty(int bountyId, int amount);
}
