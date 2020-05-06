import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';

class AccountName extends StatelessWidget {
  final TextStyle style;

  AccountName({@required this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        final account = state is Unlocked
          ? state.account
          : state is PaperBackup
          ? state.account
          : null;
        return Text(account.name, style: style);
      },
    );
  }
}
