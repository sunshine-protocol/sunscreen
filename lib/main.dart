import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sunshine/app.dart';
import 'package:sunshine/setup.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setup();
  runApp(MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

Future _setup() async {
  await configureDependencies(environment: dev);
  Intl.defaultLocale = 'en_US';
  // other pre-start setup goes here
}
