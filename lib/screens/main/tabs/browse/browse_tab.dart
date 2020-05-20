import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class BrowseTab extends StatefulWidget {
  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  bool _viewFoundations = false;
  bool _viewBounties = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilterChip(
              label: const Text('Foundations'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewFoundations ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewFoundations = v;
                  _viewBounties = !v;
                });
              },
              showCheckmark: false,
              elevation: 2,
              selected: _viewFoundations,
              selectedColor: AppColors.primary,
              disabledColor: AppColors.disabled,
            ),
            FilterChip(
              label: const Text('Bounties'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewBounties ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewBounties = v;
                  _viewFoundations = !v;
                });
              },
              showCheckmark: false,
              elevation: 4,
              selected: _viewBounties,
              selectedColor: AppColors.primary,
              disabledColor: AppColors.disabled,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(22.w.toDouble()),
          child: DropdownButton(
            isExpanded: true,
            elevation: 2,
            isDense: true,
            hint: const Text('Filter By'),
            items: ['A', 'B', 'C', 'D']
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (_) {},
          ),
        ),
        const Input(
          hintText: 'Search',
        ),
        SizedBox(height: 22.h.toDouble()),
        if (_viewBounties)
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              itemBuilder: (context, index) => BountyCard(
                tittle: 'Web3 Foundation',
                ammount: '20,000',
                bounties: index + 1,
                description:
                    'Our mission is to nurture cutting-edge applications for decentralized web software protocols.'
                    ' Our passion is delivering Web 3.0, a decentralized and fair internet where users control their'
                    ' own data, identity and destiny. The Polkadot network is our first project.',
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          )
        else if (_viewFoundations)
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              itemBuilder: (context, index) => BountyCard(
                tittle: 'Open Grants Program',
                ammount: '20,000',
                bounties: index + 1,
                description:
                    'This program offers funding for smaller technical grants of up to \$30k.'
                    ' These applications are tracked transparently on GitHub and disbursed '
                    'in cryptocurrencies',
                onPressView: () {
                  // TODO(@shekohex): Open View Foundation Info.
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
      ],
    );
  }
}

// TODO(@shekohex): move this to the ui widgets.
class BountyCard extends StatelessWidget {
  const BountyCard({
    Key key,
    this.tittle,
    this.bounties,
    this.ammount,
    this.description,
    this.onPressView,
  }) : super(key: key);

  final String tittle;
  final int bounties;
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
                    '$bounties bounties',
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
              padding: EdgeInsets.all(
                10.w.toDouble(),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 12.ssp.toDouble(),
                ),
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
