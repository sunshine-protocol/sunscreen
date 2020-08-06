import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  KeyService _keyService;
  ClientService _clientService;
  @override
  void initState() {
    super.initState();
    _keyService = GetIt.I.get<KeyService>();
    _clientService = GetIt.I.get<ClientService>();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: true,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 280.h.toDouble()),
          Center(
            child: SunshineLogo(
              height: 150.h.toDouble(),
              width: 150.w.toDouble(),
            ),
          ),
          const Expanded(child: SizedBox()),
          FutureBuilder(
            future: _clientService.ready,
            builder: _clientIsReady,
          ),
          SizedBox(height: 50.h.toDouble()),
        ],
      ),
    );
  }

  Widget _clientIsReady(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return FutureBuilder<bool>(
        future: _keyService.hasKey(),
        builder: _hasDeviceKey,
      );
    } else if (snapshot.hasError) {
      return Center(
        child: HintText(
          'error while starting up client: ${snapshot.error}',
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Column(
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          HintText('Starting up client ...'),
        ],
      );
    }
  }

  Widget _hasDeviceKey(BuildContext context, AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasData && snapshot.data) {
      Future.microtask(
        () => ExtendedNavigator.root.popAndPush(Routes.mainScreen),
      );
    } else {
      Future.microtask(
        () => ExtendedNavigator.root.popAndPush(Routes.introScreen),
      );
    }
    return Container();
  }
}
