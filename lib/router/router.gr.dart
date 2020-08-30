// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../models/models.dart';
import '../sunshine.dart';

class Routes {
  static const String blankScreen = '/blank-screen';
  static const String splashScreen = '/';
  static const String introScreen = '/intro-screen';
  static const String generateAccountStepOneScreen =
      '/generate-account-step-one-screen';
  static const String generateAccountStepTwoScreen =
      '/generate-account-step-two-screen';
  static const String generateAccountDoneScreen =
      '/generate-account-done-screen';
  static const String recoverAccountStepOneScreen =
      '/recover-account-step-one-screen';
  static const String recoverAccountStepTwoScreen =
      '/recover-account-step-two-screen';
  static const String recoverAccountDoneScreen = '/recover-account-done-screen';
  static const String mainScreen = '/main-screen';
  static const String walletTransferScreen = '/wallet-transfer-screen';
  static const String walletTransferConfirmationScreen =
      '/wallet-transfer-confirmation-screen';
  static const String walletTransferDoneScreen = '/wallet-transfer-done-screen';
  static const String accountScreen = '/account-screen';
  static const String bountyScreen = '/bounty-screen';
  static const String createBountyScreen = '/create-bounty-screen';
  static const String submitForBountyScreen = '/submit-for-bounty-screen';
  static const String devicesScreen = '/devices-screen';
  static const String paperKeyScreen = '/paper-key-screen';
  static const String revokeDeviceScreen = '/revoke-device-screen';
  static const String revokeDeviceDoneScreen = '/revoke-device-done-screen';
  static const String identitiesScreen = '/identities-screen';
  static const String proveIdentityScreen = '/prove-identity-screen';
  static const String proveIdentityInstractionsScreen =
      '/prove-identity-instractions-screen';
  static const String proveIdentityDone = '/prove-identity-done';
  static const String revokeIdentityScreen = '/revoke-identity-screen';
  static const String revokeIdentityDoneScreen = '/revoke-identity-done-screen';
  static const String loggerScreen = '/logger-screen';
  static const all = <String>{
    blankScreen,
    splashScreen,
    introScreen,
    generateAccountStepOneScreen,
    generateAccountStepTwoScreen,
    generateAccountDoneScreen,
    recoverAccountStepOneScreen,
    recoverAccountStepTwoScreen,
    recoverAccountDoneScreen,
    mainScreen,
    walletTransferScreen,
    walletTransferConfirmationScreen,
    walletTransferDoneScreen,
    accountScreen,
    bountyScreen,
    createBountyScreen,
    submitForBountyScreen,
    devicesScreen,
    paperKeyScreen,
    revokeDeviceScreen,
    revokeDeviceDoneScreen,
    identitiesScreen,
    proveIdentityScreen,
    proveIdentityInstractionsScreen,
    proveIdentityDone,
    revokeIdentityScreen,
    revokeIdentityDoneScreen,
    loggerScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.blankScreen, page: BlankScreen),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.introScreen, page: IntroScreen),
    RouteDef(Routes.generateAccountStepOneScreen,
        page: GenerateAccountStepOneScreen),
    RouteDef(Routes.generateAccountStepTwoScreen,
        page: GenerateAccountStepTwoScreen),
    RouteDef(Routes.generateAccountDoneScreen, page: GenerateAccountDoneScreen),
    RouteDef(Routes.recoverAccountStepOneScreen,
        page: RecoverAccountStepOneScreen),
    RouteDef(Routes.recoverAccountStepTwoScreen,
        page: RecoverAccountStepTwoScreen),
    RouteDef(Routes.recoverAccountDoneScreen, page: RecoverAccountDoneScreen),
    RouteDef(Routes.mainScreen, page: MainScreen),
    RouteDef(Routes.walletTransferScreen, page: WalletTransferScreen),
    RouteDef(Routes.walletTransferConfirmationScreen,
        page: WalletTransferConfirmationScreen),
    RouteDef(Routes.walletTransferDoneScreen, page: WalletTransferDoneScreen),
    RouteDef(Routes.accountScreen, page: AccountScreen),
    RouteDef(Routes.bountyScreen, page: BountyScreen),
    RouteDef(Routes.createBountyScreen, page: CreateBountyScreen),
    RouteDef(Routes.submitForBountyScreen, page: SubmitForBountyScreen),
    RouteDef(Routes.devicesScreen, page: DevicesScreen),
    RouteDef(Routes.paperKeyScreen, page: PaperKeyScreen),
    RouteDef(Routes.revokeDeviceScreen, page: RevokeDeviceScreen),
    RouteDef(Routes.revokeDeviceDoneScreen, page: RevokeDeviceDoneScreen),
    RouteDef(Routes.identitiesScreen, page: IdentitiesScreen),
    RouteDef(Routes.proveIdentityScreen, page: ProveIdentityScreen),
    RouteDef(Routes.proveIdentityInstractionsScreen,
        page: ProveIdentityInstractionsScreen),
    RouteDef(Routes.proveIdentityDone, page: ProveIdentityDone),
    RouteDef(Routes.revokeIdentityScreen, page: RevokeIdentityScreen),
    RouteDef(Routes.revokeIdentityDoneScreen, page: RevokeIdentityDoneScreen),
    RouteDef(Routes.loggerScreen, page: LoggerScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BlankScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BlankScreen(),
        settings: data,
      );
    },
    SplashScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    IntroScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => IntroScreen(),
        settings: data,
        maintainState: false,
      );
    },
    GenerateAccountStepOneScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GenerateAccountStepOneScreen(),
        settings: data,
      );
    },
    GenerateAccountStepTwoScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GenerateAccountStepTwoScreen(),
        settings: data,
      );
    },
    GenerateAccountDoneScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GenerateAccountDoneScreen(),
        settings: data,
      );
    },
    RecoverAccountStepOneScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RecoverAccountStepOneScreen(),
        settings: data,
      );
    },
    RecoverAccountStepTwoScreen: (data) {
      final args =
          data.getArgs<RecoverAccountStepTwoScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RecoverAccountStepTwoScreen(args.paperKey),
        settings: data,
      );
    },
    RecoverAccountDoneScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RecoverAccountDoneScreen(),
        settings: data,
      );
    },
    MainScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
        maintainState: true,
      );
    },
    WalletTransferScreen: (data) {
      final args = data.getArgs<WalletTransferScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WalletTransferScreen(args.amount),
        settings: data,
      );
    },
    WalletTransferConfirmationScreen: (data) {
      final args = data.getArgs<WalletTransferConfirmationScreenArguments>(
          nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WalletTransferConfirmationScreen(
          args.id,
          args.amount,
        ),
        settings: data,
      );
    },
    WalletTransferDoneScreen: (data) {
      final args =
          data.getArgs<WalletTransferDoneScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WalletTransferDoneScreen(
          args.id,
          args.amount,
        ),
        settings: data,
      );
    },
    AccountScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AccountScreen(),
        settings: data,
        maintainState: false,
      );
    },
    BountyScreen: (data) {
      final args = data.getArgs<BountyScreenArguments>(
        orElse: () => BountyScreenArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BountyScreen(bounty: args.bounty),
        settings: data,
      );
    },
    CreateBountyScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CreateBountyScreen(),
        settings: data,
      );
    },
    SubmitForBountyScreen: (data) {
      final args = data.getArgs<SubmitForBountyScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SubmitForBountyScreen(args.bounty),
        settings: data,
      );
    },
    DevicesScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DevicesScreen(),
        settings: data,
      );
    },
    PaperKeyScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => PaperKeyScreen(),
        settings: data,
      );
    },
    RevokeDeviceScreen: (data) {
      final args = data.getArgs<RevokeDeviceScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RevokeDeviceScreen(args.deviceId),
        settings: data,
      );
    },
    RevokeDeviceDoneScreen: (data) {
      final args = data.getArgs<RevokeDeviceDoneScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RevokeDeviceDoneScreen(args.deviceId),
        settings: data,
      );
    },
    IdentitiesScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => IdentitiesScreen(),
        settings: data,
      );
    },
    ProveIdentityScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProveIdentityScreen(),
        settings: data,
      );
    },
    ProveIdentityInstractionsScreen: (data) {
      final args =
          data.getArgs<ProveIdentityInstractionsScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProveIdentityInstractionsScreen(
          args.username,
          args.proveIdentityResult,
        ),
        settings: data,
      );
    },
    ProveIdentityDone: (data) {
      final args = data.getArgs<ProveIdentityDoneArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProveIdentityDone(args.service),
        settings: data,
      );
    },
    RevokeIdentityScreen: (data) {
      final args = data.getArgs<RevokeIdentityScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RevokeIdentityScreen(args.service),
        settings: data,
      );
    },
    RevokeIdentityDoneScreen: (data) {
      final args =
          data.getArgs<RevokeIdentityDoneScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RevokeIdentityDoneScreen(args.service),
        settings: data,
      );
    },
    LoggerScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoggerScreen(),
        settings: data,
        maintainState: true,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// RecoverAccountStepTwoScreen arguments holder class
class RecoverAccountStepTwoScreenArguments {
  final String paperKey;
  RecoverAccountStepTwoScreenArguments({@required this.paperKey});
}

/// WalletTransferScreen arguments holder class
class WalletTransferScreenArguments {
  final String amount;
  WalletTransferScreenArguments({@required this.amount});
}

/// WalletTransferConfirmationScreen arguments holder class
class WalletTransferConfirmationScreenArguments {
  final String id;
  final String amount;
  WalletTransferConfirmationScreenArguments(
      {@required this.id, @required this.amount});
}

/// WalletTransferDoneScreen arguments holder class
class WalletTransferDoneScreenArguments {
  final String id;
  final String amount;
  WalletTransferDoneScreenArguments({@required this.id, @required this.amount});
}

/// BountyScreen arguments holder class
class BountyScreenArguments {
  final Bounty bounty;
  BountyScreenArguments({this.bounty});
}

/// SubmitForBountyScreen arguments holder class
class SubmitForBountyScreenArguments {
  final Bounty bounty;
  SubmitForBountyScreenArguments({@required this.bounty});
}

/// RevokeDeviceScreen arguments holder class
class RevokeDeviceScreenArguments {
  final String deviceId;
  RevokeDeviceScreenArguments({@required this.deviceId});
}

/// RevokeDeviceDoneScreen arguments holder class
class RevokeDeviceDoneScreenArguments {
  final String deviceId;
  RevokeDeviceDoneScreenArguments({@required this.deviceId});
}

/// ProveIdentityInstractionsScreen arguments holder class
class ProveIdentityInstractionsScreenArguments {
  final String username;
  final ProveIdentityResult proveIdentityResult;
  ProveIdentityInstractionsScreenArguments(
      {@required this.username, @required this.proveIdentityResult});
}

/// ProveIdentityDone arguments holder class
class ProveIdentityDoneArguments {
  final String service;
  ProveIdentityDoneArguments({@required this.service});
}

/// RevokeIdentityScreen arguments holder class
class RevokeIdentityScreenArguments {
  final SocialIdentityService service;
  RevokeIdentityScreenArguments({@required this.service});
}

/// RevokeIdentityDoneScreen arguments holder class
class RevokeIdentityDoneScreenArguments {
  final SocialIdentityService service;
  RevokeIdentityDoneScreenArguments({@required this.service});
}
