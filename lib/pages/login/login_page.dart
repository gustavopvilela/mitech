/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitech/controllers/authentications.dart';
import 'package:mitech/controllers/login_controller.dart';
import 'package:mitech/models/styles/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());
  final style = Styles();
  String? errorMessage = '';

  Future<void> signWithGoogle() async {
    try {
      await Authentications().signInWithGoogle();
      Navigator.pushReplacementNamed(context, '/barraNavegacao');
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSignInButton(),
    );
  }

  Widget buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.jpg',
              height: 128,
              width: 128,
            ),

            const SizedBox(height: 55),

            ElevatedButton.icon(
              onPressed: () {
                signWithGoogle();
              },
              style: style.loginButtonStyle(
                background: Colors.white,
                foreground: Colors.black
              ),
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: const Text('Entrar com o Google')
            ),

            const SizedBox(height: 15),

            /* ElevatedButton.icon(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
              ),
              label: const Text('Entrar com o Facebook'),
              style: style.loginButtonStyle(
                background: Colors.blue.shade900,
                foreground: Colors.white
              ),
            ), */

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/loginEmail');
              },
              icon: const Icon(
                Icons.email_rounded,
                color: Colors.white
              ),
              label: const Text('Entrar utilizando email'),
              style: style.loginButtonStyle(
                background: Colors.blue,
                foreground: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}

/* Obx(() {
        if (controller.googleAccount.value == null) {
          return buildSignInButton();
        }
        else {
          return BarraNavegacao();
          /* Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const UserPage(),
            ),
          ); */
        }
      }), */ */