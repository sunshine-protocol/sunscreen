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
