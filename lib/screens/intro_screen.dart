import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  DeviceService _deviceService;
  ClientService _clientService;
  @override
  void initState() {
    super.initState();
    _deviceService = GetIt.I.get<DeviceService>();
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
          SizedBox(height: 15.h.toDouble()),
          Text(
            'Join Sunshine',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 26.ssp.toDouble(),
            ),
          ),
          SizedBox(height: 145.h.toDouble()),
          FutureBuilder(
            future: _clientService.ready,
            builder: _clientIsReady,
          ),
        ],
      ),
    );
  }

  Widget _clientIsReady(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return FutureBuilder<bool>(
        future: _deviceService.hasDeviceKey(),
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
        () => ExtendedNavigator.root
          ..pop()
          ..pushMainScreen(),
      );
      return Container();
    } else {
      return Column(
        children: [
          Button(
            variant: ButtonVariant.success,
            text: 'Generate Account',
            onPressed: () {
              // step one: Device name, we skip that for now.
              ExtendedNavigator.root.pushGenerateAccountStepTwoScreen();
            },
          ),
          SizedBox(height: 20.h.toDouble()),
          Button(
            variant: ButtonVariant.primary,
            text: 'Restore my account',
            onPressed: () {
              ExtendedNavigator.root.pushRecoverAccountStepOneScreen();
            },
          ),
        ],
      );
    }
  }
}
