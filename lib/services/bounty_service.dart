import 'package:injectable/injectable.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';

@injectable
@lazySingleton
class BountyService {
  BountyService({
    ClientService clientService,
    GithubService githubService,
  })  : _clientService = clientService,
        _githubService = githubService;

  final ClientService _clientService;
  final GithubService _githubService;

  Future<Bounty> getBounty(int bountyId) async {
    final info = await _clientService.getBounty(bountyId);
    final issue = await _githubService.getIssue(
      info.repoOwner,
      info.repoName,
      info.issueNumber,
    );
    return Bounty(info: info, issue: issue);
  }

  Future<BountySubmission> getSubmission(int submissionId) async {
    final info = await _clientService.getSubmission(submissionId);
    final issue = await _githubService.getIssue(
      info.repoOwner,
      info.repoName,
      info.issueNumber,
    );
    return BountySubmission(info: info, issue: issue);
  }

  Future<List<Bounty>> listOpenBounties(int min) async {
    final list = await _clientService.listOpenBounties(min);
    final result = <Bounty>[];
    for (final info in list) {
      final issue = await _githubService.getIssue(
        info.repoOwner,
        info.repoName,
        info.issueNumber,
      );
      result.add(Bounty(info: info, issue: issue));
    }
    return result;
  }

  Future<List<BountySubmission>> listBountySubmissions(
    int bountyId,
  ) async {
    final list = await _clientService.listBountySubmissions(bountyId);
    final result = <BountySubmission>[];
    for (final info in list) {
      final issue = await _githubService.getIssue(
        info.repoOwner,
        info.repoName,
        info.issueNumber,
      );
      result.add(BountySubmission(info: info, issue: issue));
    }
    return result;
  }

  Future<int> postBounty(
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    return _clientService.postBounty(
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }

  Future<int> submitForBounty(
    int bountyId,
    String repoOwner,
    String repoName,
    int issueNumber,
    int amount,
  ) {
    return _clientService.submitForBounty(
      bountyId,
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }

  Future<String> approveBounty(int submissionId) {
    return _clientService.approveBounty(submissionId);
  }

  Future<String> contibuteToBounty(int bountyId, int amount) {
    return _clientService.contibuteToBounty(bountyId, amount);
  }
}
