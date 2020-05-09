import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/account_model.dart';
import 'package:sunshine/services/services.dart';

class RecoverAccountViewModel extends BaseModel {
  RecoverAccountViewModel({
    @required this.accountService,
  });
  final AccountService accountService;

  bool recovered = false;

  void unlock(String phrase, String password) {
    busy();
    recovered = accountService.restore(
      phrase,
      AccountDetails(password: password),
    );
    idle();
  }
}
