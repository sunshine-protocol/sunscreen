import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/account_model.dart';
import 'package:sunshine/services/services.dart';

@injectable
class AccountPharseConfirmationViewModel extends BaseModel {
  AccountPharseConfirmationViewModel({
    @required this.accountService,
  });
  final AccountService accountService;
  bool backedUp;
  void backup(AccountBackup backup, String phrase) {
    busy();
    backedUp = accountService.confirmBackup(backup, phrase);
    idle();
  }
}
