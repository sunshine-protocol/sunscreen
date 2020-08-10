final _re = RegExp(r'^https:\/\/github\.com\/(\w+)\/(\w+)\/issues\/(\d+)$');

class GithubIssueMetadata {
  GithubIssueMetadata({this.repo, this.owner, this.issue});
  final String repo;
  final String owner;
  final int issue;
}

GithubIssueMetadata githubParseIssueUrl(String url) {
  final groups = _re.firstMatch(url)?.groups([1, 2, 3]) ?? [];
  if (groups.isEmpty) {
    return null;
  } else {
    return GithubIssueMetadata(
      owner: groups[0],
      repo: groups[1],
      issue: int.tryParse(groups[2]),
    );
  }
}
