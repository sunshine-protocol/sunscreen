import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:markdown/markdown.dart' as md;

class BountyScreen extends StatefulWidget {
  const BountyScreen({this.bounty});
  final Bounty bounty;
  @override
  _BountyScreenState createState() => _BountyScreenState();
}

class _BountyScreenState extends State<BountyScreen> {
  BountyService _bountyService;
  TextEditingController _contributionAmountController;

  @override
  void initState() {
    super.initState();
    _bountyService = GetIt.I.get<BountyService>();
    _contributionAmountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bounty = widget.bounty;
    return Scaffold(
      appBar: MyAppBar(
        title: bounty.issue.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.launch),
            onPressed: () => launch(bounty.issue.htmlUrl),
          ),
          IconButton(
            icon: const Icon(Icons.monetization_on),
            onPressed: () => _contribute(bounty),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BountyHeader(bounty: bounty),
                SizedBox(height: 8.h.toDouble()),
                HeaderText(
                  bounty.issue.title,
                ),
                SizedBox(height: 20.h.toDouble()),
                _BountyBody(
                  bounty: bounty,
                ),
                SizedBox(height: 20.h.toDouble()),
                buildBountySubmissions(bounty),
                SizedBox(height: 74.h.toDouble()),
              ],
            ),
          ),
          buildSubmitForBountyButtom(bounty),
        ],
      ),
    );
  }

  FutureBuilder<bool> buildSubmitForBountyButtom(Bounty bounty) {
    return FutureBuilder<bool>(
      initialData: false,
      future: _bountyService.canSubmitFor(bounty),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Button(
                text: 'Submit for the bounty',
                variant: ButtonVariant.success,
                onPressed: () => _submitFor(bounty)),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  FutureBuilder<List<BountySubmission>> buildBountySubmissions(Bounty bounty) {
    return FutureBuilder<List<BountySubmission>>(
      initialData: const [],
      future: _bountyService.listBountySubmissions(bounty.info.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SunshineLoading());
        } else {
          final submissions = snapshot.data
              ?.map(
                (e) => SubmissionItem(
                  bountySubmission: e,
                  bounty: bounty,
                ),
              )
              ?.toList();
          return Column(
            children: submissions ?? [],
          );
        }
      },
    );
  }

  Future<void> _submitFor(Bounty bounty) async {
    final res = await ExtendedNavigator.root.push(
      Routes.submitForBountyScreen,
      arguments: SubmitForBountyScreenArguments(bounty: bounty),
    );
    if (res != null) {
      // refresh
      setState(() {});
    }
  }

  Future<void> _contribute(Bounty bounty) async {
    final res = await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.lightBackgroud,
          title: const Text(
            'Contribute To The Bounty',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            keyboardType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: false,
            ),
            maxLines: 1,
            style: TextStyle(
              fontSize: 14.ssp.toDouble(),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            controller: _contributionAmountController,
            decoration: InputDecoration(
              hintText: 'amount',
              fillColor: const Color(0xFF616161),
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                fontSize: 14.ssp.toDouble(),
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF5F5F5).withOpacity(0.6),
              ),
            ),
          ),
          actions: [
            FlatButton(
              child: const Text(
                'Contribute',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_contributionAmountController.text.isEmpty) {
                  return;
                }
                final val = BigInt.tryParse(_contributionAmountController.text);
                if (val == null) {
                  return;
                }
                ExtendedNavigator.root.pop(true);
                await _bountyService.contibuteToBounty(
                  bounty.info.id,
                  val,
                );
              },
            ),
            FlatButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                ExtendedNavigator.root.pop();
              },
            )
          ],
        );
      },
    );
    if (res != null) {
      // refresh
      setState(() {});
    }
  }
}

class _BountyBody extends StatelessWidget {
  const _BountyBody({
    @required this.bounty,
    Key key,
  }) : super(key: key);

  final Bounty bounty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightBackgroud,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 12.h.toDouble(),
              left: 24.w.toDouble(),
              right: 24.w.toDouble(),
            ),
            child: Row(
              children: [
                Container(
                  width: 28.w.toDouble(),
                  height: 28.h.toDouble(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: const Border.fromBorderSide(
                      BorderSide(
                        color: Colors.white,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Image(
                    image: NetworkImage(
                      bounty.issue.user.avatarUrl,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.w.toDouble()),
                Text(
                  bounty.issue.user.login,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.ssp.toDouble(),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  timeago.format(bounty.issue.createdAt),
                  style: TextStyle(
                    color: const Color(0xFF989898),
                    fontSize: 12.ssp.toDouble(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.w.toDouble()),
          Padding(
            padding: const EdgeInsets.all(12),
            child: MarkdownBody(
              selectable: true,
              fitContent: true,
              onTapLink: launch,
              styleSheet: buildMarkdownStyleSheet(),
              styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
              data: bounty.issue.body,
              extensionSet: md.ExtensionSet.gitHubFlavored,
            ),
          ),
          SizedBox(height: 10.w.toDouble()),
        ],
      ),
    );
  }

  MarkdownStyleSheet buildMarkdownStyleSheet() {
    const style = TextStyle(
      color: Colors.white,
    );
    return MarkdownStyleSheet(
      a: style,
      h1: style,
      h2: style,
      h3: style,
      h4: style,
      h5: style,
      p: style,
      listBullet: style,
    );
  }
}

class _BountyHeader extends StatelessWidget {
  const _BountyHeader({
    @required this.bounty,
    Key key,
  }) : super(key: key);

  final Bounty bounty;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );
    return Padding(
      padding: EdgeInsets.only(
        top: 12.h.toDouble(),
        left: 24.w.toDouble(),
        right: 24.w.toDouble(),
      ),
      child: Row(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${bounty.info.repoOwner}/${bounty.info.repoName} #${bounty.info.issueNumber}',
              style: TextStyle(
                color: const Color(0xFF989898),
                fontSize: 14.ssp.toDouble(),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 42.w.toDouble(),
            height: 20.h.toDouble(),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  numberFormat.format(bounty.info.total.toInt()),
                  style: TextStyle(
                    color: const Color(0xFF25C100),
                    fontSize: 14.ssp.toDouble(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
