import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/setup.iconfig.dart';

@injectableInit
Future configure() async => await $initGetIt(GetIt.I);

List<SingleChildWidget> providers = [
  StreamProvider(
    initialData: const Account(),
    create: (_) => GetIt.I<AccountService>().account,
  ),
];
