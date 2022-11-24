import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mitech/controllers/authentications.dart';
import 'package:mitech/models/styles/styles.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLogin ? 'Login com Email' : 'Registrar com Email',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _entryField('Email', _controllerEmail, TextInputType.emailAddress, false),
            const SizedBox(height: 15,),
            _entryField('Senha', _controllerPassword, TextInputType.text, true),
            const SizedBox(height: 15),
            _errorMessage(),
            const SizedBox(height: 15),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Authentications().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      goToNavigationBar();
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> goToNavigationBar() async {
    await Navigator.pushReplacementNamed(context, '/barraNavegacao');
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Authentications().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText
  ) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm... $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: Styles().loginButtonStyle(),
      child: Text(isLogin ? 'Login' : 'Registrar'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Criar conta' : 'Já tem conta? Entre!'),
    );
  }
}