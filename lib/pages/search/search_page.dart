import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String posts = '';
  static const String placeholderImg = 'assets/images/noImage.jpg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: TextField(
          toolbarOptions: const ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          decoration: const InputDecoration(
            hintText: 'Pesquise aqui!',
          ),
          onChanged: (value) {
            setState(() {
              posts = value;
            });
          }
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('standardPosts').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting) ?
          const Center(
            child: CircularProgressIndicator(),
          ) :
          ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshots.data!.docs[index] /* as Map<String, dynamic> */;

              if (posts.isEmpty) {
                return ListTile(
                  title: Text(
                    item['title'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    item['subtitle'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  leading: item['imageUrl'] != null ? CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(placeholderImg),
                    imageUrl: item['imageUrl'],
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
                            title: Text(item['title']),
                            content: Column(
                              children: [
                                Text(item['subtitle']),
                                Text(item['body']),
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
              if (item['title']
                .toString()
                .toLowerCase()
                .contains(posts.toLowerCase())) {
                return ListTile(
                  title: Text(
                    item['title'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    item['subtitle'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  leading: item['imageUrl'] != null ? CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(placeholderImg),
                    imageUrl: item['imageUrl'],
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
                            title: Text(item['title']),
                            content: Column(
                              children: [
                                Text(item['subtitle']),
                                Text(item['body']),
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
              else {
                return Container();
              }
            }
          );
        },
      ),
    );
  }
}