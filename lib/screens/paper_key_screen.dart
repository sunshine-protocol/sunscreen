import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class PaperKeyScreen extends StatefulWidget {
  @override
  _PaperKeyScreenState createState() => _PaperKeyScreenState();
}

class _PaperKeyScreenState extends State<PaperKeyScreen> {
  DeviceService _deviceService;

  @override
  void initState() {
    super.initState();
    _deviceService = GetIt.I.get<DeviceService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Devices'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Device paper key'),
          SizedBox(height: 28.h.toDouble()),
          FutureBuilder<String>(
            future: _deviceService.addPaperKey(),
            initialData: '...',
            builder: (context, snapshot) => Input(
              hintText: snapshot.data,
              maxLines: 5,
              readOnly: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(22),
            child: HintText(
              'A paper key can be used to access your account in case you'
              ' lose all your devices. Keep one in a safe place '
              '(like a wallet) to keep your data safe.',
              maxLines: 4,
              softWrap: true,
            ),
          ),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Yes, I wrote it down',
            onPressed: ExtendedNavigator.root.pop,
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}
