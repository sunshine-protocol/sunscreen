import 'package:auto_route/auto_route_annotations.dart';
import 'package:sunshine/sunshine.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(page: BlankScreen),
    AdaptiveRoute(page: SplashScreen, initial: true),
    AdaptiveRoute(
      page: IntroScreen,
      maintainState: false,
    ),
    AdaptiveRoute(page: GenerateAccountStepOneScreen),
    AdaptiveRoute(page: GenerateAccountStepTwoScreen),
    AdaptiveRoute(page: GenerateAccountDoneScreen),
    AdaptiveRoute(page: RecoverAccountStepOneScreen),
    AdaptiveRoute(page: RecoverAccountStepTwoScreen),
    AdaptiveRoute(page: RecoverAccountDoneScreen),
    AdaptiveRoute(
      page: MainScreen,
      maintainState: true,
    ),
    AdaptiveRoute(page: WalletTransferScreen),
    AdaptiveRoute(page: WalletTransferConfirmationScreen),
    AdaptiveRoute(page: WalletTransferDoneScreen),
    AdaptiveRoute(
      page: AccountScreen,
      maintainState: false,
    ),
    AdaptiveRoute(page: BountyScreen),
  ],
  generateNavigationHelperExtension: false,
)
class $Router {}
