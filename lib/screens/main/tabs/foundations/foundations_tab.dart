import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class FoundationsTab extends StatefulWidget {
  @override
  _FoundationsTabState createState() => _FoundationsTabState();
}

class _FoundationsTabState extends State<FoundationsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22.h.toDouble()),
        Button(
          text: 'Create New Foundation',
          onPressed: () {},
        ),
        SizedBox(height: 22.h.toDouble()),
        Expanded(
          child: ListView.separated(
            itemCount: 2,
            itemBuilder: (context, index) => FoundationCard(
              tittle: 'Web3 Foundation',
              ammount: '20,000',
              members: index + 1,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ),
      ],
    );
  }
}

// TODO(@shekohex): move this to the ui widgets.
class FoundationCard extends StatelessWidget {
  const FoundationCard({
    Key key,
    this.tittle,
    this.members,
    this.ammount,
    this.onPressView,
  }) : super(key: key);

  final String tittle;
  final int members;
  final String ammount;
  final void Function() onPressView;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8.w.toDouble()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.w.toDouble()),
      ),
      child: Container(
        width: ScreenUtil.screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h.toDouble(),
                vertical: 20.w.toDouble(),
              ),
              child: Text(
                tittle,
                style: TextStyle(
                  fontSize: 18.ssp.toDouble(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 32.h.toDouble(),
              color: AppColors.disabled,
              padding: EdgeInsets.symmetric(
                horizontal: 16.h.toDouble(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$members member(s)',
                    style: TextStyle(
                      fontSize: 16.ssp.toDouble(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '☼ $ammount',
                    style: TextStyle(
                      fontSize: 16.ssp.toDouble(),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h.toDouble()),
              child: Button(
                text: 'View',
                variant: ButtonVariant.thin,
                onPressed: onPressView ?? () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
