import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/account/account.dart';

class QrCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            final account = state is Unlocked
              ? state.account
              : state is PaperBackup
              ? state.account
              : null;
            return Image.memory(account.qrcode);
          }
        ),
        width: 200,
        height: 200,
      ),
    );
  }
}
