import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';

class PublicKey extends StatelessWidget {
  final EdgeInsets padding;

  PublicKey({@required this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            final account = state is Unlocked
              ? state.account
              : state is PaperBackup
              ? state.account
              : null;
            return Text(account.ss58);
          },
        ),
      ),
    );
  }
}
