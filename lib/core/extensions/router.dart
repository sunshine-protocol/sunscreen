import 'package:auto_route/auto_route.dart';

extension PopPages on ExtendedNavigatorState {
  Future<void> popPages(int pages) async {
    var count = 0;
    while (canPop() && count <= pages) {
      count += 1;
      pop();
    }
  }
}
