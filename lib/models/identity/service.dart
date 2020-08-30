abstract class SocialIdentityService {
  String get username;
  String get serviceName;
  String get proofUrl;
  String get display => '$username@$serviceName';
  bool get isProved => proofUrl != null;
}
