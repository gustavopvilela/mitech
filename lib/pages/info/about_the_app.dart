import 'package:flutter/material.dart';

class AboutTheApp extends StatelessWidget {
  const AboutTheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o app'),
      ),
    );
  }
}