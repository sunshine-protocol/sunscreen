import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/services/services.dart';

@injectable
class HomeViewModel extends BaseModel {
  HomeViewModel({
    @required this.accountService,
  });
  final AccountService accountService;
  bool hasAccount = false;
  bool isUnlocked = false;
  void checkIfHasAccount() {
    busy();
    hasAccount = accountService.isInitialized();
    isUnlocked = accountService.isUnlocked();
    idle();
  }
}
