import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class CreateBountyScreen extends StatefulWidget {
  @override
  _CreateBountyScreenState createState() => _CreateBountyScreenState();
}

class _CreateBountyScreenState extends State<CreateBountyScreen> {
  BountyService _bountyService;
  TextEditingController _urlController;
  TextEditingController _amountController;
  String _errText;

  @override
  void initState() {
    super.initState();
    _bountyService = GetIt.I.get<BountyService>();
    _urlController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Create Bounty'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.fitWidth,
            child: HeaderText('Post a new Bounty'),
          ),
          SizedBox(height: 30.h.toDouble()),
          Input(
            hintText: 'Github Issue URL',
            errorText: _errText,
            controller: _urlController,
            enableSuggestions: true,
            textInputType: TextInputType.url,
            textInputAction: TextInputAction.next,
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
            hintText: 'Bounty amount',
            controller: _amountController,
            textInputType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: false,
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Builder(
            builder: (context) => Button(
              text: 'Create',
              variant: ButtonVariant.success,
              onPressed: () => _createBounty(context),
            ),
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }

  Future<void> _createBounty(BuildContext context) async {
    if (_urlController.text.isEmpty) {
      setState(() {
        _errText = 'The Url is required';
      });
      return;
    }
    final data = githubParseIssueUrl(_urlController.text);
    if (data == null) {
      setState(() {
        _errText = 'this looks like not a valid github issue url!';
      });
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      final id = await _bountyService.postBounty(
        data.owner,
        data.repo,
        data.issue,
        int.parse(_amountController.text),
      );
      print(id);
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          ExtendedNavigator.root.pop(true);
        },
      );
    } catch (_) {
      const snackbar = SnackBar(
        content: Text("Couldn't Create a bounty, check your balance"),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      final result = Scaffold.of(context).showSnackBar(snackbar);
      await result.closed;
    }
  }
}
