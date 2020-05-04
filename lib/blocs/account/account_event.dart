import 'package:meta/meta.dart';

abstract class AccountEvent {}

class Start extends AccountEvent {}

class Generate extends AccountEvent {
  final String password;

  Generate({@required this.password});
}

class Import extends AccountEvent {
  final String phrase;
  final String password;

  Import({@required this.phrase, this.password});
}

class Unlock extends AccountEvent {
  final String password;

  Unlock({@required this.password});
}

class Lock extends AccountEvent {}

class SetPaperBackup extends AccountEvent {
  final String phrase;

  SetPaperBackup({@required this.phrase});
}

class PostponeBackup extends AccountEvent {}
