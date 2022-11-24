import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitech/controllers/login_controller.dart';
import 'package:mitech/pages/login/login_page.dart';
import 'package:mitech/pages/login/login_with_email.dart';
import 'package:mitech/pages/navigation_bar.dart';
import 'package:mitech/splash.dart';
import 'package:mitech/widget_tree.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

    final controller = Get.put(LoginController());

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
        '/login': (context) => const LoginPage(),
        '/loginEmail': (context) => const LoginEmailPage(),
        '/barraNavegacao': (context) => const BarraNavegacao(),
      },
    );
  }
}