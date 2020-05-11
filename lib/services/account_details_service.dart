import 'package:injectable/injectable.dart';
import 'package:sunshine/models/models.dart';

@lazySingleton
class AccountDetailsService {
  AccountDetails value = const AccountDetails();
}
