import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/services/services.dart';

class UnlockAccountViewModel extends BaseModel {
  UnlockAccountViewModel({
    @required this.accountService,
  });
  final AccountService accountService;

  bool unlocked = false;

  void unlock(String password) {
    busy();
    unlocked = accountService.unlock(password);
    idle();
  }
}
