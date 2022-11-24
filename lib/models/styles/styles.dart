import 'package:flutter/material.dart';

class Styles {
  ButtonStyle loginButtonStyle({Color? background, Color? foreground}) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(270, 55)),
      backgroundColor: MaterialStateProperty.all(background),
      foregroundColor: MaterialStateProperty.all(foreground),
      elevation: MaterialStateProperty.all(5),
      padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          letterSpacing: 1.15,
          fontWeight: FontWeight.w600,
        ),
      )
    );
  }
}