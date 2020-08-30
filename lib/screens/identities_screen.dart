import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class IdentitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Identities'),
      body: _IdentitesScreenBody(),
    );
  }
}

class _IdentitesScreenBody extends StatefulWidget {
  const _IdentitesScreenBody({
    Key key,
  }) : super(key: key);

  @override
  __IdentitesScreenBodyState createState() => __IdentitesScreenBodyState();
}

class __IdentitesScreenBodyState extends State<_IdentitesScreenBody> {
  final _accountService = GetIt.I.get<AccountService>();

  SocialIdentityService _github;

  @override
  Widget build(BuildContext context) {
    return ListCell(
      title: 'Github',
      trailing: SizedBox(
        width: 80.w.toDouble(),
        child: FutureBuilder<List<SocialIdentityService>>(
          future: _accountService.identities(),
          initialData: [
            GithubIdentity(proofUrl: null, username: '...'),
          ],
          builder: (context, snapshot) {
            _github = snapshot.data?.firstWhere(
              (id) => id.serviceName == 'github',
              orElse: () => null,
            );
            return HintText(_github?.username ?? 'N/A');
          },
        ),
      ),
      onTap: () {
        _showActions(context);
      },
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.mainBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: 180.h.toDouble(),
          child: Column(
            children: [
              SizedBox(height: 5.h.toDouble()),
              SizedBox(
                width: 100.w.toDouble(),
                child: const Divider(
                  thickness: 2,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 20.h.toDouble()),
              if (_github != null && _github.isProved) ...[
                Button(
                  text: 'View Proof',
                  variant: ButtonVariant.success,
                  onPressed: () async {
                    if (await canLaunch(_github.proofUrl)) {
                      ExtendedNavigator.root.pop();
                      await launch(_github.proofUrl);
                    }
                  },
                ),
                SizedBox(height: 10.h.toDouble()),
                Button(
                  text: 'Revoke',
                  variant: ButtonVariant.danger,
                  onPressed: () {
                    ExtendedNavigator.root
                      ..pop()
                      ..push(
                        Routes.revokeIdentityScreen,
                        arguments:
                            RevokeIdentityScreenArguments(service: _github),
                      );
                  },
                )
              ] else ...[
                Button(
                  text: 'Prove',
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    ExtendedNavigator.root
                      ..pop()
                      ..push(Routes.proveIdentityScreen);
                  },
                ),
                SizedBox(height: 10.h.toDouble()),
                Button(
                  text: 'Cancel',
                  variant: ButtonVariant.secondry,
                  onPressed: ExtendedNavigator.root.pop,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ProveIdentityScreen extends StatefulWidget {
  @override
  _ProveIdentityScreenState createState() => _ProveIdentityScreenState();
}

class _ProveIdentityScreenState extends State<ProveIdentityScreen> {
  TextEditingController _username;
  String _errText;
  IdentityService _identityService;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _identityService = GetIt.I.get<IdentityService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Identities'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Prove your Github identity'),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: 'Github Username',
            controller: _username,
            errorText: _errText,
            maxLength: 38,
            onChanged: (_) {
              if (_errText != null) {
                _errText = null;
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(
                  r'^[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}$',
                  caseSensitive: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h.toDouble()),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Next',
            variant: ButtonVariant.success,
            onPressed: () async => await _proveGithubIdentity(context),
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }

  Future<void> _proveGithubIdentity(BuildContext context) async {
    if (_username.text.isEmpty || _username.text.length < 3) {
      setState(() {
        _errText = 'Please Provide a valid username';
      });
      return;
    }
    // hide keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      final result = await _identityService.proveIdentity(
        GithubIdentity(username: _username.text, proofUrl: null),
      );
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          ExtendedNavigator.root.push(
            Routes.proveIdentityInstractionsScreen,
            arguments: ProveIdentityInstractionsScreenArguments(
              username: _username.text,
              proveIdentityResult: result,
            ),
          );
        },
      );
    } catch (_) {
      const snackbar = SnackBar(
        content: Text("you don't have enough tokens to complete transaction"),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class ProveIdentityInstractionsScreen extends StatefulWidget {
  const ProveIdentityInstractionsScreen(
    this.username,
    this.proveIdentityResult,
  );
  final String username;
  final ProveIdentityResult proveIdentityResult;
  @override
  _ProveIdentityInstractionsScreenState createState() =>
      _ProveIdentityInstractionsScreenState();
}

class _ProveIdentityInstractionsScreenState
    extends State<ProveIdentityInstractionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Github',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText('Hey, ${widget.username}'),
            SizedBox(height: 15.h.toDouble()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w.toDouble()),
              child: HintText(
                widget.proveIdentityResult.instructions,
                maxLines: 4,
                softWrap: true,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 15.h.toDouble()),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Input(
                initialValue: widget.proveIdentityResult.proof,
                maxLines: 16,
                readOnly: true,
              ),
            ),
            SizedBox(height: 24.h.toDouble()),
            _CopyToClipboardButton(text: widget.proveIdentityResult.proof),
            SizedBox(height: 10.h.toDouble()),
            const _CheckIdentityButton(),
            SizedBox(height: 15.h.toDouble()),
          ],
        ),
      ),
    );
  }
}

class _CheckIdentityButton extends StatelessWidget {
  const _CheckIdentityButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'OK posted, Check for it!',
      variant: ButtonVariant.success,
      onPressed: () async {
        await _checkIdentity(context);
      },
    );
  }

  Future<void> _checkIdentity(BuildContext context) async {
    final _accountService = GetIt.I.get<AccountService>();
    final identities = await _accountService.identities();
    final github = identities.firstWhere(
      (s) => s.serviceName == 'github' && s.isProved,
      orElse: () => null,
    );
    if (github != null) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          ExtendedNavigator.root.push(
            Routes.proveIdentityDone,
            arguments: ProveIdentityDoneArguments(service: github.display),
          );
        },
      );
    } else {
      // not proved yet!
      const snackbar = SnackBar(
        content: Text('No Proof found, please post it first'),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class _CopyToClipboardButton extends StatelessWidget {
  const _CopyToClipboardButton({
    @required this.text,
    Key key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'Copy to clipboard',
      variant: ButtonVariant.primary,
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        const snackbar = SnackBar(content: Text('Copied to clipboard'));
        Scaffold.of(context).showSnackBar(snackbar);
      },
    );
  }
}

class ProveIdentityDone extends StatelessWidget {
  const ProveIdentityDone(this.service);
  final String service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h.toDouble()),
          const HeaderText('You successfully proved'),
          SizedBox(height: 30.h.toDouble()),
          Input(
            hintText: service,
            readOnly: true,
          ),
          SizedBox(height: 20.h.toDouble()),
          const HeaderText('and now part of your identity'),
          SizedBox(height: 30.h.toDouble()),
          const SunshineLogo(),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root.push(Routes.identitiesScreen);
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}

class RevokeIdentityScreen extends StatelessWidget {
  const RevokeIdentityScreen(this.service);
  final SocialIdentityService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Identities'),
      body: Column(
        children: [
          SizedBox(height: 50.h.toDouble()),
          const HeaderText('Your are about to revoke'),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: service.display,
            readOnly: true,
          ),
          SizedBox(height: 40.h.toDouble()),
          const HeaderText('Are you sure?'),
          SizedBox(height: 20.h.toDouble()),
          const HintText('you can prove it again if you changed your mind'),
          const Expanded(child: SizedBox()),
          SizedBox(height: 20.h.toDouble()),
          Button(
            text: 'Yes, Revoke',
            variant: ButtonVariant.danger,
            onPressed: () {
              _revokeIdentity(context);
            },
          ),
          SizedBox(height: 10.h.toDouble()),
          Button(
            text: 'No, go back',
            variant: ButtonVariant.secondry,
            onPressed: ExtendedNavigator.root.pop,
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }

  Future<void> _revokeIdentity(BuildContext context) async {
    final _identityService = GetIt.I.get<IdentityService>();
    final result = await _identityService.revokeIdentity(service);
    if (result) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          ExtendedNavigator.root.push(
            Routes.revokeIdentityDoneScreen,
            arguments: RevokeIdentityDoneScreenArguments(service: service),
          );
        },
      );
    } else {
      // not proved yet!
      const snackbar = SnackBar(
        content: Text('Oh uh, we failed to revoke this identity!'),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class RevokeIdentityDoneScreen extends StatelessWidget {
  const RevokeIdentityDoneScreen(this.service);
  final SocialIdentityService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h.toDouble()),
          const HeaderText('You successfully revoked'),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: service.display,
            readOnly: true,
          ),
          SizedBox(height: 20.h.toDouble()),
          const HeaderText('from your identities'),
          SizedBox(height: 40.h.toDouble()),
          const SunshineLogo(),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root.push(Routes.identitiesScreen);
            },
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}
