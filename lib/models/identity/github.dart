import 'package:meta/meta.dart';

import 'service.dart';

class GithubIdentity extends SocialIdentityService {
  GithubIdentity({
    @required String username,
    @required String proofUrl,
  })  : _username = username,
        _proofUrl = proofUrl;
  final String _username;
  final String _proofUrl;

  @override
  String get serviceName => 'github';

  @override
  String get username => _username;

  @override
  String get proofUrl => _proofUrl;
}
