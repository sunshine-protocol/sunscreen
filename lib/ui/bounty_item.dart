import 'package:flutter/material.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'package:timeago/timeago.dart' as timeago;

class BountyItem extends StatefulWidget {
  const BountyItem({
    this.repoName,
    this.issueNumber,
    this.repoOwner,
    this.githubIssue,
    this.depositer,
    this.total,
  });
  final String repoName;
  final String repoOwner;
  final String issueNumber;
  final GithubIssue githubIssue;
  final String depositer;
  final String total;

  @override
  _BountyItemState createState() => _BountyItemState();
}

class _BountyItemState extends State<BountyItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h.toDouble(),
      child: Column(
        children: [
          _BountyHeader(parent: widget),
          _BountyBody(parent: widget),
          _BountyFooter(parent: widget)
        ],
      ),
    );
  }
}

class _BountyHeader extends StatelessWidget {
  const _BountyHeader({
    @required this.parent,
    Key key,
  }) : super(key: key);

  final BountyItem parent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.h.toDouble(),
        left: 12.w.toDouble(),
        right: 9.w.toDouble(),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w.toDouble(),
            height: 16.h.toDouble(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green,
              border: const Border.fromBorderSide(
                BorderSide(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w.toDouble()),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${parent.repoOwner}/${parent.repoOwner} #${parent.issueNumber}',
              style: TextStyle(
                color: const Color(0xFF989898),
                fontSize: 14.ssp.toDouble(),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            timeago.format(parent.githubIssue.createdAt),
            style: TextStyle(
              color: const Color(0xFF989898),
              fontSize: 12.ssp.toDouble(),
            ),
          ),
          SizedBox(width: 8.w.toDouble()),
        ],
      ),
    );
  }
}

class _BountyBody extends StatelessWidget {
  const _BountyBody({
    @required this.parent,
    Key key,
  }) : super(key: key);

  final BountyItem parent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.h.toDouble(),
        left: 12.w.toDouble(),
        right: 9.w.toDouble(),
      ),
      child: Row(
        children: [
          SizedBox(width: 28.w.toDouble()),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              parent.githubIssue.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.ssp.toDouble(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 22.w.toDouble(),
            height: 18.h.toDouble(),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  parent.total,
                  style: TextStyle(
                    color: const Color(0xFF25C100),
                    fontSize: 12.ssp.toDouble(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w.toDouble()),
        ],
      ),
    );
  }
}

class _BountyFooter extends StatelessWidget {
  const _BountyFooter({
    @required this.parent,
    Key key,
  }) : super(key: key);

  final BountyItem parent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.h.toDouble(),
        left: 12.w.toDouble(),
        right: 9.w.toDouble(),
      ),
      child: Row(
        children: [
          SizedBox(width: 28.w.toDouble()),
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
                parent.githubIssue.user.avatarUrl,
              ),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 5.w.toDouble()),
          Text(
            parent.githubIssue.body,
            style: TextStyle(
              color: const Color(0xFF989898),
              fontSize: 12.ssp.toDouble(),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 16.w.toDouble(),
            height: 16.h.toDouble(),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${parent.githubIssue.comments}',
                  style: TextStyle(
                    color: const Color(0xFF989898),
                    fontSize: 12.ssp.toDouble(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w.toDouble()),
        ],
      ),
    );
  }
}
