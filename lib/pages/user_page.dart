import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mitech/controllers/authentications.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //final controller = Get.put(LoginController());
  String? errorMessage = '';

  Future<void> signOutAccount() async {
    try {
      await Authentications().signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Under construction.'),
        ),
        
        /* Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: Image.network(FirebaseAuth.instance.currentUser!.photoURL ?? 'https://cdn.pixabay.com/photo/2017/01/10/03/54/avatar-1968236_960_720.png').image,
                  radius: 45,
                ),
                const SizedBox(height: 16),
                Text(FirebaseAuth.instance.currentUser!.displayName ?? 'Usuário anônimo'),
                Text(FirebaseAuth.instance.currentUser!.email ?? ''),

                const SizedBox(
                  height: 55,
                ),

                const Divider(),

                const ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.question,
                  ),
                  title: Text('Sobre a aplicação'),
                  subtitle: Text('Informações técnicas e tudo o mais'),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.follow_the_signs_rounded),
                  title: const Text('Encerrar sessão na aplicação'),
                  subtitle: const Text('Até mais!'),
                  trailing: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text('Sair mesmo?'),
                                Divider(),
                              ],
                            ),
                            content: const Text('Você está prestes a deslogar do aplicativo. Não se preocupe, futuramente você poderá logar novamente.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Colors.red
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  signOutAccount();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Confirmar', style: TextStyle(color: Colors.blue.shade700),),
                              ),
                            ],
                          );
                        }
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair')
                  ),
                ),

                const Divider(),
              ],
            ),
          ),
        ), */
      ),
    );
  }
}