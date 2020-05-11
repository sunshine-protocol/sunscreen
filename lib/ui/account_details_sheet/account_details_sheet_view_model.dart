import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/sunshine.dart';

@injectable
class AccountDetailsSheetViewModel extends BaseModel {
  AccountDetailsSheetViewModel({
    @required this.accountService,
  });
  final AccountService accountService;
  Account account;
  void loadAccount() {
    busy();
    account = accountService.loadAccount();
    idle();
  }

  void setFirstName(String v) {
    busy();
    if (v.isNotEmpty) {
      accountService.preferences.setString(SharedPrefKeys.firstName, v);
    }
    idle();
  }

  void setLastName(String v) {
    busy();
    if (v.isNotEmpty) {
      accountService.preferences.setString(SharedPrefKeys.lastName, v);
    }
    idle();
  }
}
