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
  String password;
  String phrase;
  void recover() {
    busy();
    recovered = accountService.restore(
      AccountDetails(
        password: password,
        phrase: phrase,
      ),
    );
    idle();
  }

  void setPassword(String v) {
    busy();
    password = v;
    idle();
  }

  void setPharse(String v) {
    busy();
    phrase = v;
    idle();
  }
}
