import 'package:sunshine/models/models.dart';
import 'package:injectable/injectable.dart';

import 'client/client_service.dart';

@lazySingleton
class IdentityService {
  IdentityService({ClientService clientService})
      : _clientService = clientService;

  final ClientService _clientService;

  Future<String> uidOf(String id) {
    return _clientService.uidOf(id);
  }

  Future<List<SocialIdentityService>> identities(String uid) {
    return _clientService.identities(uid).then(
          (ids) => ids.map(_parse).toList(),
        );
  }

  Future<ProveIdentityResult> proveIdentity(SocialIdentityService service) {
    return _clientService.proveIdentity(service);
  }

  Future<bool> revokeIdentity(SocialIdentityService service) {
    return _clientService.revokeIdentity(service);
  }

  SocialIdentityService _parse(String identity) {
    print(identity);
    if (identity.contains('gist.github.com')) {
      final parts = identity.split(' ');
      print(parts);
      final parts2 = parts[0].split('@');
      return GithubIdentity(username: parts2[0], proofUrl: parts[1]);
    } else {
      return GithubIdentity(username: null, proofUrl: null);
    }
  }
}
