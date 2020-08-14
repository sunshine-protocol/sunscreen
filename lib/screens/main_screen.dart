import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine_ffi/dto.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BountyService bountyService;
  @override
  void initState() {
    super.initState();
    bountyService = GetIt.I.get<BountyService>();
  }

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
          onPressed: () {
            ExtendedNavigator.root.push(Routes.accountScreen);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              final res = await ExtendedNavigator.root.push(
                Routes.createBountyScreen,
              );
              if (res != null) {
                // refresh
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<List<Bounty>>(
          initialData: const [],
          builder: _buildList,
          future: bountyService.listOpenBounties(BigInt.one),
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AsyncSnapshot<List<Bounty>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return ListView.builder(
        itemBuilder: (_, i) => SizedBox(
          width: ScreenUtil.screenWidthPx,
          height: 80,
          child: Shimmer.fromColors(
            baseColor: AppColors.mainBackground,
            highlightColor: AppColors.success,
            child: BountyItem(
              bounty: Bounty(
                info: BountyInformation(
                  issueNumber: BigInt.from(i) + BigInt.one,
                  repoName: 'sunshine',
                  repoOwner: 'sunshine',
                  total: BigInt.from(1000),
                ),
                issue: GithubIssue(
                  createdAt: DateTime.now(),
                  number: 0,
                  title: getRandomIssueTitle(),
                  user: User(
                    avatarUrl:
                        'https://avatars0.githubusercontent.com/u/55122894',
                  ),
                ),
              ),
            ),
          ),
        ),
        itemCount: rnd.nextInt(8) + 1,
      );
    }
    if (snapshot.hasData) {
      return ListView.separated(
        itemBuilder: (_, i) {
          final bounty = snapshot.data[i];
          return GestureDetector(
            child: BountyItem(
              bounty: bounty,
            ),
            onLongPress: () => launch(bounty.issue.htmlUrl),
            onTap: () async {
              debugPrint('Open Bounty ${bounty.info.id}');
              final res = await ExtendedNavigator.root.push(
                Routes.bountyScreen,
                arguments: BountyScreenArguments(
                  bounty: bounty,
                ),
              );
              if (res != null) {
                // refresh
                setState(() {});
              }
            },
          );
        },
        separatorBuilder: (context, _) => const Divider(
          color: AppColors.disabled,
          thickness: 0.2,
        ),
        itemCount: snapshot.data.length,
      );
    } else {
      return const Center(child: SunshineLoading());
    }
  }
}
