import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';

class GenerateAccountStepOneScreen extends StatefulWidget {
  @override
  _GenerateAccountStepOneScreenState createState() =>
      _GenerateAccountStepOneScreenState();
}

class _GenerateAccountStepOneScreenState
    extends State<GenerateAccountStepOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Generate Account'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Choose your Device Name'),
          SizedBox(height: 30.h.toDouble()),
          const Input(
            hintText: 'ex. Android Phone',
          ),
          SizedBox(height: 30.h.toDouble()),
          const Center(
            child: HintText(
              'Your name will only be stored on your device '
              'we don\'t share it anywhere else.',
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Button(
            text: 'Next',
            variant: ButtonVariant.success,
            onPressed: () {
              ExtendedNavigator.root.pushGenerateAccountStepTwoScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}

class GenerateAccountStepTwoScreen extends StatefulWidget {
  @override
  _GenerateAccountStepTwoScreenState createState() =>
      _GenerateAccountStepTwoScreenState();
}

class _GenerateAccountStepTwoScreenState
    extends State<GenerateAccountStepTwoScreen> {
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
      appBar: const MyAppBar(title: 'Generate Account'),
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
              text: 'Generate',
              variant: ButtonVariant.success,
              onPressed: () => _generateAccount(context),
            ),
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }

  Future<void> _generateAccount(BuildContext context) async {
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
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      await _keyService.generate(_passwordController.text);
      await Future.delayed(
        const Duration(milliseconds: 100),
        () {
          ExtendedNavigator.root.pushGenerateAccountDoneScreen();
        },
      );
    } catch (_) {
      ExtendedNavigator.root.pop();
      final snackbar = SnackBar(
        content: const Text("Couldn't generate the account"),
        backgroundColor: AppColors.danger,
        duration: const Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class GenerateAccountDoneScreen extends StatelessWidget {
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
            'Your Account has been created\n'
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
          const HeaderText('That\'s your device id in your account'),
          SizedBox(height: 30.h.toDouble()),
          FutureBuilder<Account>(
            initialData: const Account(devices: [
              Device(
                id: '...',
                currentDevice: true,
              )
            ]),
            future: f,
            builder: (context, snapshot) => Input(
              hintText: snapshot.data.currentDevice.id,
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
              ExtendedNavigator.root
                ..pop()
                ..pop()
                ..pushMainScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}
