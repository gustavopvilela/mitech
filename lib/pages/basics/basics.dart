import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mitech/controllers/firestore_manager.dart';

class Basics extends StatefulWidget {
  const Basics({Key? key}) : super(key: key);

  @override
  State<Basics> createState() => _BasicsState();
}

class _BasicsState extends State<Basics> {
  List standardPostsList = [];
  static const String placeholderImg = 'assets/images/noImage.jpg';
  
  
  @override
  void initState() {
    super.initState();
    fetchStandardPostsList();
  }

  fetchStandardPostsList() async {
    dynamic result = await FirestoreManager().getBasicPostsList();

    if (result == null) {
      print('No such posts');
    }
    else {
      setState(() {
        standardPostsList = result;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: standardPostsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              standardPostsList[index]['title'],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(
              standardPostsList[index]['subtitle'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            leading: standardPostsList[index]['imageUrl'] != null ? CachedNetworkImage(
              placeholder: (context, url) => Image.asset(placeholderImg),
              imageUrl: standardPostsList[index]['imageUrl'],
              height: 50,
              width: 50,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ) :
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(placeholderImg),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(standardPostsList[index]['title']),
                      content: Column(
                        children: [
                          Text(standardPostsList[index]['subtitle']),
                          Text(standardPostsList[index]['body']),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Fechar',
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
            },
          );
        }
      ),
    );
  }
}