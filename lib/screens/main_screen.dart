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
      amount: '1K',
    );
  }
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
          ),
        ),
        borderRadius: BorderRadius.circular(
          32.w.toDouble(),
        ),
      ),
      child: const Icon(
        Icons.add,
        size: 32,
        color: Colors.white,
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.w.toDouble(),
        ),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
