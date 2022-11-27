import 'package:flutter/material.dart';
import 'package:mitech/controllers/authentications.dart';
import 'package:mitech/pages/login/login_page.dart';
import 'package:mitech/pages/navigation_bar.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Authentications().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BarraNavegacao();
        }
        else {
          return const BarraNavegacao();
        }
      },
    );
  }
}