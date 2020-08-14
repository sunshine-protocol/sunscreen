final _re = RegExp(
    r'^https:\/\/github\.com\/([A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*)\/([A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*)\/issues\/(\d+)$');

class GithubIssueMetadata {
  GithubIssueMetadata({this.repo, this.owner, this.issue});
  final String repo;
  final String owner;
  final BigInt issue;
}

GithubIssueMetadata githubParseIssueUrl(String url) {
  final groups = _re.firstMatch(url)?.groups([1, 2, 3]) ?? [];
  if (groups.isEmpty) {
    return null;
  } else {
    return GithubIssueMetadata(
      owner: groups[0],
      repo: groups[1],
      issue: BigInt.tryParse(groups[2]),
    );
  }
}
