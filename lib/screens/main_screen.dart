import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bounties',
        leading: IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: _buildItem,
        separatorBuilder: (context, _) => const Divider(
          color: AppColors.disabled,
          thickness: 0.2,
        ),
        itemCount: 20,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return const BountyItem(
      repoName: 'sunshine-bounty',
      repoOwner: 'sunshine-protocol',
      issueNumber: '137',
      total: '1K',
    );
  }
}
