import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/account_model.dart';
import 'package:sunshine/services/services.dart';

@injectable
class GenerateAccountViewModel extends BaseModel {
  GenerateAccountViewModel({
    @required AccountService accountService,
    @required AccountDetailsService accountDetailsService,
  })  : _accountService = accountService,
        _accountDetailsService = accountDetailsService;
  final AccountService _accountService;
  final AccountDetailsService _accountDetailsService;
  AccountBackup accountBackup;
  void generate() {
    busy();
    accountBackup = _accountService.generate(_accountDetailsService.value);
    idle();
  }
}
