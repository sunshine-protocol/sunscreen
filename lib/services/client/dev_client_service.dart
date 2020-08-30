import 'package:injectable/injectable.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine_ffi/dto.dart';

import 'client_service.dart';

@dev
@LazySingleton(as: ClientService)
class DevClientService implements ClientService {
  String _uid;
  String _balance = '1000000';
  String _password = '12345678';
  String _deviceId;

  final Map<String, Set<String>> _identities = {};
  final Map<String, Set<String>> _devices = {};

  @override
  Future<String> deviceId() async {
    return _deviceId;
  }

  @override
  Future<bool> addDevice(String id) async {
    return _devices[_uid].add(id);
  }

  @override
  Future<List<String>> devices() async {
    return _devices[_uid].toList();
  }

  @override
  Future<bool> revokeDevice(String id) async {
    return _devices[_uid].remove(id);
  }

  @override
  Future<bool> revokeIdentity(SocialIdentityService service) async {
    return _identities[_uid].remove(service.display);
  }

  @override
  Future<String> addPaperKey() async {
    const paperKey = 'mandate robust earth scan shrimp second pipe pitch'
        ' eternal snap glare tooth bean crucial river bar'
        ' crash nice sorry laundry oppose filter aunt swear';
    return paperKey;
  }

  @override
  Future<bool> hasKey() async {
    return _uid != null;
  }

  @override
  Future<bool> get ready => Future.delayed(
        const Duration(seconds: 2),
        () => true,
      );

  @override
  Future<bool> lock() async {
    return true;
  }

  @override
  Future<String> setKey(String password, {String suri, String paperKey}) async {
    _password = password;
    _uid = '1';
    _balance = '0';
    _deviceId = '5GrwvaEF5zXb26Fz9rcQpDWS57CEfgh';
    _identities[_uid] = {'5GrwvaEF5zXb26Fz9rcQpDWS57CEfgh'};
    _devices[_uid] = {};
    await Future.delayed(const Duration(seconds: 2));
    return _uid;
  }

  @override
  Future<bool> unlock(String password) async {
    if (password == _password) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> balance() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _balance ?? '100000000';
  }

  @override
  Future<String> transfer(String id, BigInt amount) {
    throw UnimplementedError();
  }

  @override
  Future<String> uid() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _uid;
  }

  @override
  Future<BigInt> mint() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _balance = (int.parse(_balance) + 1000000).toString();
    return BigInt.from(1000000);
  }

  @override
  Future<String> approveBounty(BigInt submissionId) async {
    await Future.delayed(const Duration(milliseconds: 999));
    final sub = await getSubmission(submissionId);
    final bounty = await getBounty(sub.bountyId);
    bounty.approve(sub);
    return sub.amount.toString();
  }

  @override
  Future<String> contibuteToBounty(BigInt bountyId, BigInt amount) async {
    await Future.delayed(const Duration(milliseconds: 999));
    final bounty = await getBounty(bountyId);
    return bounty?.contibute(amount).toString() ?? '0';
  }

  @override
  Future<BountyInformation> getBounty(BigInt bountyId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockedBounties.firstWhere(
      (e) => e.id == bountyId,
      orElse: () => null,
    );
  }

  @override
  Future<BountySubmissionInformation> getSubmission(BigInt submissionId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockedSubmissions.firstWhere(
      (e) => e.id == submissionId,
      orElse: () => null,
    );
  }

  @override
  Future<List<BountySubmissionInformation>> listBountySubmissions(
    BigInt bountyId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return _mockedSubmissions
        .where((e) => e.awaitingReview)
        .where((e) => e.bountyId == bountyId)
        .toList()
          ..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<List<BountyInformation>> listOpenBounties(BigInt min) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return _mockedBounties
        .where((e) => e.isOpen)
        .where((e) => e.total >= min)
        .toList()
          ..sort((a, b) => a.id.compareTo(b.id));
  }

  @override
  Future<BigInt> postBounty(
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final last = _mockedBounties.last;
    final v = BountyInformation(
      depositer: await uid(),
      id: last.id + BigInt.from(1),
      issueNumber: issueNumber,
      repoName: repoName,
      repoOwner: repoOwner,
      total: amount,
    );
    _mockedBounties.add(v);
    return v.id;
  }

  @override
  Future<BigInt> submitForBounty(
    BigInt bountyId,
    String repoOwner,
    String repoName,
    BigInt issueNumber,
    BigInt amount,
  ) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final last = _mockedSubmissions.last;
    final v = BountySubmissionInformation(
      id: last.id + BigInt.one,
      bountyId: bountyId,
      issueNumber: issueNumber,
      repoName: repoName,
      repoOwner: repoOwner,
      amount: amount,
      awaitingReview: true,
      submitter: await uid(),
    );
    _mockedSubmissions.add(v);
    return v.id;
  }

  @override
  Future<List<String>> identities(String uid) async {
    return _identities[uid].toList();
  }

  @override
  Future<ProveIdentityResult> proveIdentity(
      SocialIdentityService service) async {
    _identities[_uid].add(service.display);
    if (service.serviceName == 'github') {
      return const ProveIdentityResult(
        'Login to your Github account and paste the text below'
        ' into a Public gist called substrate-identity-proof.md',
        _instractionsForDemo,
      );
    } else {
      return null;
    }
  }

  @override
  Future<String> uidOf(String id) {
    throw UnimplementedError();
  }
}

const _instractionsForDemo = '''
### substrate identity proof

I hereby claim:

  * I am shekohex on github.
  * I am 0 on the substrate chain with genesis hash mzyTJZVm7IXDUBeZwyWk6rG1YGIt8BQnNzrshKJCalYI.
  * I have a public key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY valid at block with hash mfBFseDYNX31Poqei8A/9teYmxJIj4PFROoKLKEPaStE.

To claim this, I am signing this object:

{"block":[124,17,108,120,54,13,95,125,79,162,167,162,240,15,253,181,230,38,196,146,35,224,241,81,58,130,139,40,67,218,74,209],"body":{"Ownership":[{"Github":["dvc94ch"]}]},"ctime":1591448931056,"expire_in":18446744073709551615,"genesis":[207,36,201,101,89,187,33,112,212,5,230,112,201,105,58,172,109,88,24,139,124,5,9,205,206,187,33,40,144,154,149,130],"prev":null,"public":"5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY","seqno":1,"uid":0}

with the key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY, yielding the signature:

mAU6Gon1dqctnS/zPKHd9gWFvEJBqADvgYQy0OFuamA5CwVQk7papR0xBq8DijRqSXVGpJtNFmy7aYJk5cGLxv4c

And finally, I am proving ownership of the github account by posting this as a gist.
''';

final List<BountyInformation> _mockedBounties = [
  BountyInformation(
    id: BigInt.from(1),
    depositer: '1',
    total: BigInt.from(5595),
    repoOwner: 'bluzelle',
    repoName: 'swarm-of-duty',
    issueNumber: BigInt.from(2),
  ),
  BountyInformation(
    id: BigInt.from(2),
    depositer: '1',
    total: BigInt.from(22288),
    repoOwner: 'aragonone',
    repoName: 'hack-for-freedom',
    issueNumber: BigInt.from(7),
  ),
  BountyInformation(
    id: BigInt.from(3),
    depositer: '1',
    total: BigInt.from(100000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(29),
  ),
  BountyInformation(
    id: BigInt.from(4),
    depositer: '1',
    total: BigInt.from(15000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(30),
  ),
];

final List<BountySubmissionInformation> _mockedSubmissions = [
  BountySubmissionInformation(
    id: BigInt.from(1),
    bountyId: BigInt.from(1),
    awaitingReview: true,
    submitter: '1',
    amount: BigInt.from(6000),
    repoOwner: 'ArweaveTeam',
    repoName: 'Bounties',
    issueNumber: BigInt.from(29),
  ),
  BountySubmissionInformation(
    id: BigInt.from(2),
    bountyId: BigInt.from(1),
    awaitingReview: true,
    submitter: '3',
    amount: BigInt.from(6500),
    repoOwner: 'aragonone',
    repoName: 'hack-for-freedom',
    issueNumber: BigInt.from(7),
  ),
];
