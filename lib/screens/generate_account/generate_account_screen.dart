import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/core/core.dart';
import 'package:sunshine/sunshine.dart';
import 'generate_account_view_model.dart';

// ignore: must_be_immutable
class GenerateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<GenerateAccountViewModel>(
      model: GenerateAccountViewModel(
        accountService: Provider.of(context),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Generate Account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          // ignore: avoid_as
          appBar: child as PreferredSizeWidget,
          body: Stack(
            children: [
              AccountDetailsForm(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 42.h.toDouble()),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: model.isBusy
                      ? const CircularProgressIndicator()
                      : Button(
                          text: 'Proceed to backup phrase',
                          onPressed: () {
                            model.generate(context.read());
                            Navigator.of(context).popAndPushNamed(
                              Routes.accountPharse,
                              arguments: model.accountBackup,
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
