import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'package:timeago/timeago.dart' as timeago;

class BountyItem extends StatefulWidget {
  const BountyItem({
    this.bounty,
  });
  final Bounty bounty;

  @override
  _BountyItemState createState() => _BountyItemState();
}

class _BountyItemState extends State<BountyItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 81.h.toDouble(),
      child: Column(
        children: [
          _BountyHeader(parent: widget),
          _BountyBody(parent: widget),
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
                parent.bounty.issue.user.avatarUrl,
              ),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 10.w.toDouble()),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${parent.bounty.info.repoOwner}/${parent.bounty.info.repoName} #${parent.bounty.info.issueNumber}',
              style: TextStyle(
                color: const Color(0xFF989898),
                fontSize: 14.ssp.toDouble(),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            timeago.format(parent.bounty.issue.createdAt),
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
  _BountyBody({
    @required this.parent,
    Key key,
  }) : super(key: key);

  final BountyItem parent;
  final numberFormat = NumberFormat.compactCurrency(
    decimalDigits: 0,
    symbol: '',
  );

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
          SizedBox(width: 40.w.toDouble()),
          Container(
            width: 250.w.toDouble(),
            height: 20.h.toDouble(),
            child: Text(
              parent.bounty.issue.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.ssp.toDouble(),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 36.w.toDouble(),
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
                  numberFormat.format(parent.bounty.info.total.toInt()),
                  style: TextStyle(
                    color: const Color(0xFF25C100),
                    fontSize: 12.ssp.toDouble(),
                    fontWeight: FontWeight.bold,
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
