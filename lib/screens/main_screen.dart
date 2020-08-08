import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine_ffi/dto.dart';

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
            onPressed: () {
              // TODO(shekohex): open add bounty screen
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
          future: bountyService.listOpenBounties(0),
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
                  issueNumber: i + 1,
                  repoName: 'sunshine',
                  repoOwner: 'sunshine',
                  total: 100,
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
        itemBuilder: (_, i) => BountyItem(bounty: snapshot.data[i]),
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
