import 'package:auto_route/auto_route.dart';

class HasAccountGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(
    ExtendedNavigatorState navigator,
    String routeName,
    Object arguments,
  ) async {
    return true;
  }
}
