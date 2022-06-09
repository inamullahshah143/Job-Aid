import 'package:flutter/material.dart';
import 'package:job_aid/authentication/pages/splash_screen.dart';
import 'package:job_aid/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Aid',
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: KColors.appThemeColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              KColors.primary,
            ),
            shape: MaterialStateProperty.all(
              const StadiumBorder(),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              KColors.primary,
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline3: TextStyle(
            color: KColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: KColors.title,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headline5: TextStyle(
            color: KColors.primary,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          headline6: TextStyle(
            color: KColors.primary,
            fontSize: 25,
          ),
          bodyText2: TextStyle(
            color: KColors.title,
          ),
        ),
      ),
      home: const SplashScreen(
        title: 'Job Aid',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
