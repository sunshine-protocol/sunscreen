import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';

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
}
