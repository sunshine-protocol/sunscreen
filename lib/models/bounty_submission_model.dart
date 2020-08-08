import 'package:sunshine/models/github_issue_model.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine_ffi/dto.dart';

class BountySubmission {
  BountySubmission({
    @required this.info,
    @required this.issue,
  });
  final BountySubmissionInformation info;
  final GithubIssue issue;
}
