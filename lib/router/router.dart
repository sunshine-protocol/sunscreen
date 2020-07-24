import 'package:auto_route/auto_route_annotations.dart';
import 'package:sunshine/sunshine.dart';

export 'guards/guards.dart';
export 'router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(page: BlankScreen, initial: true),
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
