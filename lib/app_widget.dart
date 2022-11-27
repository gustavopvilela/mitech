import 'package:flutter/material.dart';
import 'package:mitech/pages/info/about_the_app.dart';
import 'package:mitech/pages/info/how_to_use.dart';
import 'package:mitech/pages/login/login_with_email.dart';
import 'package:mitech/pages/navigation_bar.dart';
import 'package:mitech/splash.dart';
import 'package:mitech/widget_tree.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF8AA868),
        ),
        fontFamily: 'San Francisco'
      ),
      initialRoute:'/',
      routes: {
        '/': (context) => const Splash(),
        '/widgetTree': (context) => const WidgetTree(),
        '/loginEmail': (context) => const LoginEmailPage(),
        '/barraNavegacao': (context) => const BarraNavegacao(),
        '/howToUse': (context) => const HowToUse(),
        '/aboutTheApp': (context) => const AboutTheApp(),
      },
    );
  }
}