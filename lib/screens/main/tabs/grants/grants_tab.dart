import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/screens/main/tabs/applications/applications_tab.dart';

class GrantsTab extends StatefulWidget {
  @override
  _GrantsTabState createState() => _GrantsTabState();
}

class _GrantsTabState extends State<GrantsTab> {
  bool _viewActive = true;
  bool _viewClosed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilterChip(
              label: const Text('Active'),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: _viewActive ? Colors.white : Colors.black,
                fontSize: 18.ssp.toDouble(),
              ),
              onSelected: (v) {
                setState(() {
                  _viewActive = v;
                });
              },
              showCheckmark: false,
              elevation: 2,
              selected: _viewActive,
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
            itemCount: 2,
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
