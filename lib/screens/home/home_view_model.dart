import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/account_model.dart';
import 'package:sunshine/services/services.dart';

class HomeViewModel extends BaseModel {
  HomeViewModel({
    @required this.accountService,
  });
  final AccountService accountService;

  bool hasAccount = false;

  Future checkIfHasAccount() async {
    busy();
    final state = await Future.microtask(accountService.state);
    print(state);
    hasAccount = state == AccountState.locked;
    idle();
    print(hasAccount);
  }
}
