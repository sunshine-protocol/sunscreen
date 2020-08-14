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

  @override
  void initState() {
    super.initState();
    _bountyService = GetIt.I.get<BountyService>();
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
            onPressed: () => {
              // TODO(shekohex): show Contribute screen
            },
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
                FutureBuilder<List<BountySubmission>>(
                  initialData: const [],
                  future: _bountyService.listBountySubmissions(bounty.info.id),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        ...snapshot.data.map(buildSubmission),
                      ],
                    );
                  },
                ),
                SizedBox(height: 74.h.toDouble()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Button(
              text: 'Submit for the bounty',
              variant: ButtonVariant.success,
              onPressed: () async {
                final res = await ExtendedNavigator.root.push(
                  Routes.submitForBountyScreen,
                  arguments: SubmitForBountyScreenArguments(bounty: bounty),
                );
                if (res != null) {
                  // refresh
                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // TODO(shekohex): move this widget to a seprate file in ui
  Widget buildSubmission(BountySubmission e) {
    final numberFormat = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );
    return Dismissible(
      key: Key(e.info.id.toString()),
      background: Container(color: Colors.green),
      confirmDismiss: (c) async {
        await showCupertinoDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Approve?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.ssp.toDouble(),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: AppColors.mainBackground,
            content: Text(
              'Are you sure want to approve this submission?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.ssp.toDouble(),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            actions: [
              FlatButton(
                child: const Text('Approve'),
                onPressed: () {
                  // TODO(shekohex): approve this submission
                },
              ),
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  ExtendedNavigator.root.pop();
                },
              ),
            ],
          ),
        );
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: 58,
          color: AppColors.lightBackgroud,
          child: Padding(
            padding: EdgeInsets.only(
              top: 12.h.toDouble(),
              bottom: 12.h.toDouble(),
              left: 12.w.toDouble(),
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
                      e.issue.user.avatarUrl,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.w.toDouble()),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '#${e.info.submitter} (@${e.issue.user.login}) '
                    'Submitted for ${numberFormat.format(e.info.amount)}',
                    style: TextStyle(
                      color: const Color(0xFF989898),
                      fontSize: 14.ssp.toDouble(),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: IconButton(
                    icon: const Icon(
                      Icons.launch,
                      color: Colors.white,
                    ),
                    onPressed: () => launch(e.issue.htmlUrl),
                  ),
                ),
                SizedBox(width: 8.w.toDouble()),
              ],
            ),
          ),
        ),
      ),
    );
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
    return MarkdownStyleSheet(
      a: const TextStyle(
        color: Colors.white,
      ),
      h1: const TextStyle(
        color: Colors.white,
      ),
      h2: const TextStyle(
        color: Colors.white,
      ),
      h3: const TextStyle(
        color: Colors.white,
      ),
      h4: const TextStyle(
        color: Colors.white,
      ),
      h5: const TextStyle(
        color: Colors.white,
      ),
      p: const TextStyle(
        color: Colors.white,
      ),
      listBullet: const TextStyle(
        color: Colors.white,
      ),
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
