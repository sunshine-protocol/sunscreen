import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/account_model.dart';
import 'package:sunshine/services/services.dart';

class GenerateAccountViewModel extends BaseModel {
  GenerateAccountViewModel({
    @required this.accountService,
  });
  final AccountService accountService;
  AccountBackup accountBackup;
  void generate(AccountDetails details) {
    busy();
    accountBackup = accountService.generate(details);
    idle();
  }
}
