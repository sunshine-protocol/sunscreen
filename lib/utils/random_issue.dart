import 'dart:math';

const List<String> _randomIssue = [
  'Building Sunshine Interface',
  'Sunshine Bounty Platform',
  'Build A Bounties Or Roles App On Aragon',
  '(500,000 SC) - Build On Skynet',
  'Gnosis Conditional Token Frame - Fork The World Hackathon Bounty',
];
final rnd = Random();

String getRandomIssueTitle() {
  final i = rnd.nextInt(_randomIssue.length);
  return _randomIssue[i];
}
