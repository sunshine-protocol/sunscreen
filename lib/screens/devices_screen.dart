import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';
import 'package:sunshine/models/models.dart';

class DevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Devices'),
      body: _DeviceScreenBody(),
    );
  }
}

class _DeviceScreenBody extends StatelessWidget {
  const _DeviceScreenBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _accountService = GetIt.I.get<AccountService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderText('Your Devices'),
        SizedBox(height: 15.w.toDouble()),
        const Center(
          child: HintText('Tip: click on any device to see more actions'),
        ),
        SizedBox(height: 10.w.toDouble()),
        SizedBox(
          height: ScreenUtil.screenHeight - 162,
          child: Stack(
            children: [
              FutureBuilder<List<Device>>(
                future: _accountService.devices(),
                initialData: const [Device(id: '...')],
                builder: _buildDevices,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.h.toDouble()),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    text: 'Create a Paper Key',
                    onPressed: () {
                      ExtendedNavigator.root.pushPaperKeyScreen();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDevices(_, AsyncSnapshot<List<Device>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, i) => ListCell(
        title: snapshot.data[i]?.id ?? 'No ID?',
        trailing: SizedBox(
          width: 120.w.toDouble(),
          child: snapshot.data[i].currentDevice
              ? const HintText('Current Device')
              : null,
        ),
        onTap: () {
          _showActions(context, snapshot.data[i]?.id);
        },
      ),
    );
  }

  void _showActions(BuildContext context, String deviceId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: 180.h.toDouble(),
          child: Column(
            children: [
              SizedBox(height: 5.h.toDouble()),
              SizedBox(
                width: 100.w.toDouble(),
                child: Divider(
                  thickness: 2,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20.h.toDouble()),
              Button(
                text: 'Revoke',
                variant: ButtonVariant.danger,
                onPressed: () {
                  ExtendedNavigator.root
                    ..pop()
                    ..pushRevokeDeviceScreen(deviceId: deviceId);
                },
              ),
              SizedBox(height: 10.h.toDouble()),
              Button(
                text: 'Cancel',
                variant: ButtonVariant.secondry,
                onPressed: ExtendedNavigator.root.pop,
              ),
            ],
          ),
        );
      },
    );
  }
}

class RevokeDeviceScreen extends StatelessWidget {
  const RevokeDeviceScreen(this.deviceId);
  final String deviceId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Devices'),
      body: Column(
        children: [
          SizedBox(height: 50.h.toDouble()),
          const HeaderText('Your are about to revoke'),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: deviceId,
            readOnly: true,
          ),
          SizedBox(height: 40.h.toDouble()),
          const HeaderText('Are you sure?'),
          SizedBox(height: 20.h.toDouble()),
          const HintText('There is no way to reverse this'),
          const Expanded(child: SizedBox()),
          SizedBox(height: 20.h.toDouble()),
          _RevokeDeviceButton(deviceId: deviceId),
          SizedBox(height: 10.h.toDouble()),
          Button(
            text: 'No, go back',
            variant: ButtonVariant.secondry,
            onPressed: ExtendedNavigator.root.pop,
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}

class _RevokeDeviceButton extends StatelessWidget {
  const _RevokeDeviceButton({
    @required this.deviceId,
    Key key,
  }) : super(key: key);

  final String deviceId;
  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'Yes, Revoke',
      variant: ButtonVariant.danger,
      onPressed: () {
        _revokeDevice(context);
      },
    );
  }

  Future<void> _revokeDevice(BuildContext context) async {
    final _deviceService = GetIt.I.get<DeviceService>();
    try {
      final result = await _deviceService.revokeDevice(deviceId);
      if (result) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            ExtendedNavigator.root
              ..popPages(1)
              ..pushRevokeDeviceDoneScreen(deviceId: deviceId);
          },
        );
      } else {
        ExtendedNavigator.root.pop();
        final snackbar = SnackBar(
          content: const Text("Couldn't Remove this device !"),
          backgroundColor: AppColors.danger,
          duration: const Duration(seconds: 5),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      }
    } catch (_) {
      ExtendedNavigator.root.pop();
      final snackbar = SnackBar(
        content:
            const Text("you don't have enough tokens to complete transaction"),
        backgroundColor: AppColors.danger,
        duration: const Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class RevokeDeviceDoneScreen extends StatelessWidget {
  const RevokeDeviceDoneScreen(this.deviceId);
  final String deviceId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h.toDouble()),
          const HeaderText('You successfully revoked'),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: deviceId,
            readOnly: true,
          ),
          SizedBox(height: 20.h.toDouble()),
          const HeaderText('from your devices'),
          SizedBox(height: 40.h.toDouble()),
          const SunshineLogo(),
          // SizedBox(height: 40.h.toDouble()),
          // const HintText('you now have only 1 device(s)'),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root
                ..popPages(1)
                ..pushDevicesScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}
