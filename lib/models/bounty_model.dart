import 'package:sunshine/models/github_issue_model.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine_ffi/dto.dart';

class Bounty {
  Bounty({
    @required this.info,
    @required this.issue,
  });
  final BountyInformation info;
  final GithubIssue issue;
}
