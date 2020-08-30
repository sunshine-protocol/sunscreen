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
    AdaptiveRoute(page: CreateBountyScreen),
    AdaptiveRoute(page: SubmitForBountyScreen),
    AdaptiveRoute(page: DevicesScreen),
    AdaptiveRoute(page: PaperKeyScreen),
    AdaptiveRoute(page: RevokeDeviceScreen),
    AdaptiveRoute(page: RevokeDeviceDoneScreen),
    AdaptiveRoute(page: IdentitiesScreen),
    AdaptiveRoute(page: ProveIdentityScreen),
    AdaptiveRoute(page: ProveIdentityInstractionsScreen),
    AdaptiveRoute(page: ProveIdentityDone),
    AdaptiveRoute(page: RevokeIdentityScreen),
    AdaptiveRoute(page: RevokeIdentityDoneScreen),
    AdaptiveRoute(
      page: LoggerScreen,
      maintainState: true,
    ),
  ],
  generateNavigationHelperExtension: false,
)
class $Router {}
