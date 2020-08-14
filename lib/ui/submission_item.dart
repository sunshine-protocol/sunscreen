import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmissionItem extends StatelessWidget {
  const SubmissionItem(this.bountySubmission);
  final BountySubmission bountySubmission;
  @override
  Widget build(BuildContext context) {
    final bountyService = GetIt.I.get<BountyService>();
    final e = bountySubmission;
    final numberFormat = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );
    return Dismissible(
      key: Key(e.info.id.toString()),
      background: Container(color: Colors.green),
      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          final snackbar = SnackBar(
            content: Text('Approving (@${e.issue.user.login}) ...'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
              textColor: Colors.white,
            ),
            duration: const Duration(seconds: 5),
          );
          final result = Scaffold.of(context).showSnackBar(snackbar);
          final reason = await result.closed;
          if (reason == SnackBarClosedReason.action) {
            return false;
          } else {
            await bountyService.approveBounty(e.info.id);
            // ignore: unawaited_futures
            Future.delayed(const Duration(milliseconds: 200))
                .whenComplete(() => ExtendedNavigator.root.pop(true));
            return true;
          }
        } else {
          return false;
        }
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
                    'Submitted for '
                    '${numberFormat.format(e.info.amount.toInt())}',
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
