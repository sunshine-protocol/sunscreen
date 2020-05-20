import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class ApplicationsTab extends StatefulWidget {
  @override
  _ApplicationsTabState createState() => _ApplicationsTabState();
}

class _ApplicationsTabState extends State<ApplicationsTab> {
  bool _viewSubmitted = true;
  bool _viewPending = false;
  bool _viewClosed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilterChip(
              label: const Text('Submitted'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewSubmitted ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewSubmitted = v;
                });
              },
              showCheckmark: false,
              elevation: 2,
              selected: _viewSubmitted,
              selectedColor: AppColors.primary,
              disabledColor: AppColors.disabled,
            ),
            FilterChip(
              label: const Text('Pending'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewPending ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewPending = v;
                });
              },
              showCheckmark: false,
              elevation: 4,
              selected: _viewPending,
              selectedColor: AppColors.primary,
              disabledColor: AppColors.disabled,
            ),
            FilterChip(
              label: const Text('Closed'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewClosed ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewClosed = v;
                });
              },
              showCheckmark: false,
              elevation: 4,
              selected: _viewClosed,
              selectedColor: AppColors.primary,
              disabledColor: AppColors.disabled,
            ),
          ],
        ),
        SizedBox(height: 22.h.toDouble()),
        Expanded(
          child: ListView.separated(
            itemCount: 4,
            itemBuilder: (context, index) => ApplicationCard(
              tittle: 'Web3 Foundation',
              ammount: '20,000',
              members: index + 1,
              description: 'Open Grants Program',
              shares: 12,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ),
      ],
    );
  }
}

// TODO(@shekohex): move this to the ui widgets.
class ApplicationCard extends StatelessWidget {
  const ApplicationCard({
    Key key,
    this.tittle,
    this.members,
    this.ammount,
    this.shares,
    this.description,
    this.onPressView,
  }) : super(key: key);

  final String tittle;
  final int members;
  final int shares;
  final String ammount;
  final String description;
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
              padding: EdgeInsets.symmetric(
                horizontal: 16.h.toDouble(),
                vertical: 6.h.toDouble(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.ssp.toDouble(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'You have: ',
                      style: TextStyle(
                        fontSize: 14.ssp.toDouble(),
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      children: [
                        TextSpan(
                          text: '$shares shares',
                          style: TextStyle(
                            fontSize: 14.ssp.toDouble(),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h.toDouble()),
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
