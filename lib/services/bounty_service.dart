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

  Future<Bounty> getBounty(BigInt bountyId) async {
    final info = await _clientService.getBounty(bountyId);
    final issue = await _githubService.getIssue(
      info.repoOwner,
      info.repoName,
      info.issueNumber.toInt(),
    );
    if (issue == null) {
      return null;
    }
    return Bounty(info: info, issue: issue);
  }

  Future<BountySubmission> getSubmission(BigInt submissionId) async {
    final info = await _clientService.getSubmission(submissionId);
    final issue = await _githubService.getIssue(
      info.repoOwner,
      info.repoName,
      info.issueNumber.toInt(),
    );
    if (issue == null) {
      return null;
    }
    return BountySubmission(info: info, issue: issue);
  }

  Future<List<Bounty>> listOpenBounties(BigInt min) async {
    final list = await _clientService.listOpenBounties(min);
    final result = <Bounty>[];
    for (final info in list) {
      final issue = await _githubService.getIssue(
        info.repoOwner,
        info.repoName,
        info.issueNumber.toInt(),
      );
      if (issue == null) {
        continue;
      }
      result.add(Bounty(info: info, issue: issue));
    }
    return result;
  }

  Future<List<BountySubmission>> listBountySubmissions(
    BigInt bountyId,
  ) async {
    final list = await _clientService.listBountySubmissions(bountyId);
    final result = <BountySubmission>[];
    for (final info in list) {
      final issue = await _githubService.getIssue(
        info.repoOwner,
        info.repoName,
        info.issueNumber.toInt(),
      );
      if (issue == null) {
        continue;
      }
      result.add(BountySubmission(info: info, issue: issue));
    }
    return result;
  }

  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) {
    return _clientService.postBounty(
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }

  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) {
    return _clientService.submitForBounty(
      bountyId,
      repoOwner,
      repoName,
      issueNumber,
      amount,
    );
  }

  Future<String> approveBounty(BigInt submissionId) {
    return _clientService.approveBounty(submissionId);
  }

  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount) {
    return _clientService.contibuteToBounty(bountyId, amount);
  }

  Future<bool> canSubmitFor(Bounty bounty) async {
    final uid = await _clientService.uid();
    return uid != bounty.info.depositer;
  }

  Future<bool> canApprove(Bounty bounty) async {
    final uid = await _clientService.uid();
    return uid == bounty.info.depositer;
  }
}
