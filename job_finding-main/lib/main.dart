import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'router_name.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Kstrings.appName,
      theme: MyTheme.theme,
      initialRoute: Routes.splashScreen,
      routes: Routes.routes,
    );
  }
}
