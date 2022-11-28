import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações')
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Como utilizar o app?'),
            subtitle: const Text('Veja as principais funções!'),
            leading: const Icon(Icons.question_mark_rounded),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).pushNamed('/howToUse');
            },
          ),

          ListTile(
            title: const Text('Informações do aplicativo'),
            subtitle: const Text('Coisas em técnicas'),
            leading: const Icon(Icons.info),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).pushNamed('/aboutTheApp');
            },
          ),

          Image.asset('assets/images/info_image.png'),
        ],
      ),
    );
  }
}