import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class BountyItem extends StatefulWidget {
  const BountyItem({
    this.repoName,
    this.issueNumber,
    this.repoOwner,
    this.amount,
  });
  final String repoName;
  final String repoOwner;
  final String issueNumber;
  final String amount;

  @override
  _BountyItemState createState() => _BountyItemState();
}

class _BountyItemState extends State<BountyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h.toDouble(),
      child: Column(
        children: [
          Padding(
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
                    '${widget.repoOwner}/${widget.repoOwner} #${widget.issueNumber}',
                    style: TextStyle(
                      color: const Color(0xFF989898),
                      fontSize: 14.ssp.toDouble(),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  '6m',
                  style: TextStyle(
                    color: const Color(0xFF989898),
                    fontSize: 12.ssp.toDouble(),
                  ),
                ),
                SizedBox(width: 8.w.toDouble()),
              ],
            ),
          ),
          Padding(
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
                    'List Bounties',
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
                        widget.amount,
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
          ),
          Padding(
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
                  child: const Image(
                    image: NetworkImage(
                      'https://avatars3.githubusercontent.com/u/25728274',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 5.w.toDouble()),
                Text(
                  'In a perfect world, the client/UI listens to events...',
                  style: TextStyle(
                    color: const Color(0xFF989898),
                    fontSize: 12.ssp.toDouble(),
                  ),
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
                        '3',
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
          )
        ],
      ),
    );
  }
}
