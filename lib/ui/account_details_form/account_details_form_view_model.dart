import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';

@injectable
class AccountDetailsFormViewModel extends BaseModel {
  AccountDetailsFormViewModel({
    @required AccountDetailsService accountDetailsService,
  }) : _accountDetailsService = accountDetailsService;

  final AccountDetailsService _accountDetailsService;
  AccountDetails get accountDetails => _accountDetailsService.value;
  void update(AccountDetails details) {
    busy();
    _accountDetailsService.value = details;
    idle();
  }
}
