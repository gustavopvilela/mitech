import 'package:flutter/material.dart';

class AboutTheApp extends StatefulWidget {
  AboutTheApp({Key? key}) : super(key: key);

  @override
  State<AboutTheApp> createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  TextStyle size = TextStyle(fontSize: 15);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
	  appBar: AppBar(
        title: const Text('Sobre o app'),
      ),
	  body: Padding(
	  padding: EdgeInsets.all(32.0),
	  child: Column(
		mainAxisAlignment: MainAxisAlignment.center,
		crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				Text(
					'M.I. Tech\n',
					style: TextStyle(
						fontWeight: FontWeight.w600,
						fontSize: 19,
					),
				),
				Text('Versão 1.0.0\n', style: size),
				Text('Aplicativo construído como Trabalho de Conclusão de Curso para o Curso Técnico em Informática do Instituto Federal de Educação, Ciência e Tecnologia de Minas Gerais, Campus Formiga, pelo aluno Gustavo Henrique Pereira Vilela. O contato com o autor pode ser feito através de gustavohp.vilela@gmail.com.', style: size),
		],
	  ),
	  ),
    );
  }
}