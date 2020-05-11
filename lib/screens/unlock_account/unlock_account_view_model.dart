import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/services/services.dart';

@injectable
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
