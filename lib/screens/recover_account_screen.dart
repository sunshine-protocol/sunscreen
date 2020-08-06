import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';

class RecoverAccountStepOneScreen extends StatefulWidget {
  @override
  _RecoverAccountStepOneScreenState createState() =>
      _RecoverAccountStepOneScreenState();
}

class _RecoverAccountStepOneScreenState
    extends State<RecoverAccountStepOneScreen> {
  TextEditingController _paperKeyController;
  String _errText;
  @override
  void initState() {
    super.initState();
    _paperKeyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Recover Account'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Enter your device paper key'),
          SizedBox(height: 30.h.toDouble()),
          Input(
            maxLines: 4,
            minLines: 4,
            errorText: _errText,
            onChanged: (_) {
              if (_errText != null) {
                _errText = null;
              }
            },
            controller: _paperKeyController,
            hintText: 'mandate robust earth scan shrimp second pipe pitch'
                ' eternal snap glare tooth bean crucial river bar'
                ' crash nice sorry laundry oppose filter aunt swear',
          ),
          SizedBox(height: 10.h.toDouble()),
          const Expanded(
            child: SizedBox(),
          ),
          Button(
            text: 'Next',
            variant: ButtonVariant.success,
            onPressed: () {
              if (_paperKeyController.text.trim().isEmpty) {
                setState(() {
                  _errText = '??!';
                });
                return;
              }
              FocusScope.of(context).requestFocus(FocusNode());
              ExtendedNavigator.root.popAndPush(
                Routes.recoverAccountStepTwoScreen,
                arguments: RecoverAccountStepTwoScreenArguments(
                  paperKey: _paperKeyController.text,
                ),
              );
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}

class RecoverAccountStepTwoScreen extends StatefulWidget {
  const RecoverAccountStepTwoScreen(this.paperKey);
  final String paperKey;
  @override
  _RecoverAccountStepTwoScreenState createState() =>
      _RecoverAccountStepTwoScreenState();
}

class _RecoverAccountStepTwoScreenState
    extends State<RecoverAccountStepTwoScreen> {
  KeyService _keyService;
  TextEditingController _passwordController;
  TextEditingController _passwordAgainController;
  String _errText;
  @override
  void initState() {
    super.initState();
    _keyService = GetIt.I.get<KeyService>();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Recover Account'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.fitWidth,
            child: HeaderText('Add a password to secure your account'),
          ),
          SizedBox(height: 30.h.toDouble()),
          Input(
            hintText: 'Password',
            obscureText: true,
            errorText: _errText,
            controller: _passwordController,
            onChanged: (v) {
              if (_errText != null) {
                setState(() {
                  _errText = null;
                });
              }
            },
          ),
          SizedBox(height: 14.h.toDouble()),
          Input(
            hintText: 'Password Again',
            obscureText: true,
            errorText: _errText,
            controller: _passwordAgainController,
            onChanged: (v) {
              if (_errText != null) {
                setState(() {
                  _errText = null;
                });
              }
            },
          ),
          SizedBox(height: 30.h.toDouble()),
          const Center(
            child: HintText('Password must be at least 8 characters'),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Builder(
            builder: (context) => Button(
              text: 'Restore',
              variant: ButtonVariant.success,
              onPressed: () => _restoreAccount(context),
            ),
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }

  Future<void> _restoreAccount(BuildContext context) async {
    final isLessThan8 = _passwordController.text.length < 8 ||
        _passwordAgainController.text.length < 8;
    if (isLessThan8) {
      setState(() {
        _errText = 'Please choose a password that at least 8 characters';
      });
      return;
    }
    if (_passwordController.text != _passwordAgainController.text) {
      setState(() {
        _errText = 'Passwords dose not match';
      });
      return;
    }
    // hide keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      await _keyService.restore(
        _passwordController.text,
        widget.paperKey,
      );
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          ExtendedNavigator.root.popAndPush(Routes.recoverAccountDoneScreen);
        },
      );
    } catch (_) {
      ExtendedNavigator.root.pop();
      const snackbar = SnackBar(
        content: Text(
          "Couldn't restore your account, check the paperkey again",
        ),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class RecoverAccountDoneScreen extends StatelessWidget {
  final _accountService = GetIt.I.get<AccountService>();
  @override
  Widget build(BuildContext context) {
    final f = _accountService.currentAccount();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100.h.toDouble()),
          const HeaderText(
            'Your Account has been restored\n'
            'Here is your account id',
          ),
          SizedBox(height: 30.h.toDouble()),
          FutureBuilder<Account>(
            initialData: const Account(uid: '...'),
            future: f,
            builder: (context, snapshot) => Input(
              hintText: snapshot.data.uid,
              readOnly: true,
            ),
          ),
          SizedBox(height: 30.h.toDouble()),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HintText(
                'you could access these information '
                'in your profile page.',
                maxLines: 2,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root.popAndPush(Routes.mainScreen);
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}
