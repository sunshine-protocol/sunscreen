import 'package:flutter/material.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';

class SubmitForBountyScreen extends StatefulWidget {
  const SubmitForBountyScreen(this.bounty);
  final Bounty bounty;
  @override
  _SubmitForBountyScreenState createState() => _SubmitForBountyScreenState();
}

class _SubmitForBountyScreenState extends State<SubmitForBountyScreen> {
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
    final bounty = widget.bounty;
    return Scaffold(
      appBar: const MyAppBar(title: 'Bounty Submission'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: HeaderText('Submit for ${bounty.issue.title} Bounty'),
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
            hintText: 'tokens amount',
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
              text: 'Submit',
              variant: ButtonVariant.success,
              onPressed: () => _submitForBounty(context),
            ),
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }

  Future<void> _submitForBounty(BuildContext context) async {
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
      final id = await _bountyService.submitForBounty(
        widget.bounty.info.id,
        data.owner,
        data.repo,
        data.issue,
        BigInt.parse(_amountController.text),
      );
      print('Submitted for bounty with: $id');
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          ExtendedNavigator.root.pop(true);
        },
      );
    } catch (_) {
      const snackbar = SnackBar(
        content: Text("Couldn't Submit for that bounty, try again"),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 5),
      );
      final result = Scaffold.of(context).showSnackBar(snackbar);
      await result.closed;
    }
  }
}
