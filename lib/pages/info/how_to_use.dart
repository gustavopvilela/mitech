import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  HowToUse({Key? key}) : super(key: key);

  TextStyle size = TextStyle(fontSize: 15);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
	  appBar: AppBar(
        title: Text('Como usar'),
      ),
      body: Padding(
		padding: EdgeInsets.all(32.0),
		child: SingleChildScrollView(
			child: Column(
			  mainAxisAlignment: MainAxisAlignment.center,
			  crossAxisAlignment: CrossAxisAlignment.center,
			  children: [
				Image.asset(
					'assets/images/icon.jpg',
					width: 100,
					height: 100,
				),
				
				SizedBox(height: 35),
				
				Text(
					'Seja bem-vindo(a) ao M.I. Tech!\n',
					style: TextStyle(
						fontWeight: FontWeight.w600,
						fontSize: 19,
					),
				),
				
				Text('Ao entrar no aplicativo, a primeira tela é a que vai te mostrar as notícias. São as mais recentes sobre o mundo digital. Todos os dias elas são atualizadas.\n', style: size),
				
				Text('Caso se interesse por alguma delas, é possível salvá-la para ler mais tarde. Basta arrastar a notícia desejada para o lado direito que aparecerá um botão para salvar, na cor azul. Ao lado desse botão, haverá outro, da cor amarela, que permite compartilhar o link da notícia com outras pessoas, basta clicar nele.\n', style: size),
				
				Image.asset('assets/images/videosalvar.gif'),
				
				Text('A notícia que você salvou vai para o menu de salvos. Para acessá-lo, vá na parte de baixo da tela do app e clique no 1º botão da esquerda para a direita. Ele mostrará as notícias que você salvou anteriormente.\n', style: size),
				
				Text('Caso não se interesse mais por alguma delas, basta arrastar para o lado direito e haverá um botão vermelho para deletá-la. É importante dizer que essa ação não pode ser revertida, uma vez excluída, a informação não voltará. Da mesma forma, ao lado do botão de deletar, há um botão amarelo para compartilhar.\n', style: size),
				
				Image.asset('assets/images/videodeletar.gif'),
				
				Text('Há também o menu de informações que são mais comuns os usuários acessarem, ou seja, quem tem dúvidas sobre algo, vai diretamente para lá. Chamamos essas informações de notícias-padrão. Para acessá-las, basta olhar o menu do lado de baixo da tela e clicar no ícone do lado direito do ícone do menu de salvos.\n', style: size),
				
				Text('Caso queira pesquisar alguma notícia padrão específica, clique no ícone de pesquisa. É o quarto da esquerda para a direita no menu inferior.\n', style: size),
				
				Text('E pronto! Simples, não? Aproveite muito o M.I. Tech!', style: size),
			  ],
			),
		  ),
	  ),
    );
  }
}