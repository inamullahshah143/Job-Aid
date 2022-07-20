import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router_name.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';

SharedPreferences? prefs;
FirebaseAuth? _auth;
get user => _auth!.currentUser;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
await Firebase.initializeApp().whenComplete(() async {
    _auth = FirebaseAuth.instance;
  });
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Kstrings.appName,
      theme: MyTheme.theme,
      initialRoute: Routes.splashScreen,
      routes: Routes.routes,
    );
  }
}
