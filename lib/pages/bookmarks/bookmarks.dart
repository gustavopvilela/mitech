import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mitech/controllers/bookmarked_posts_controller.dart';
import 'package:mitech/models/bookmarked_posts_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  static const String placeholderImg = 'assets/images/noImage.jpg';
  List<Widget> _bookmarksListView = [];
  List<BookmarkedPostsModel> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _setListView();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notícias salvas')
      ),
      body: _bookmarks.isEmpty ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 25,),
              Text('Suas notícias salvas aparecerão aqui.',),
            ],
          ),
        ) :
        ListView.builder(
          itemCount: _bookmarks.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      try {
                        _deleteBookmark(_bookmarks[index].id!);
                        print('Deletou!');
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            dismissDirection: DismissDirection.startToEnd,
                            behavior: SnackBarBehavior.floating,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.delete_sweep, color: Colors.white),
                                SizedBox(width: 25,),
                                Text(
                                  'Notícia deletada!',
                                  style: TextStyle(
                                    fontFamily: 'San Francisco'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      catch (_) {
                        print('Erro!');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange.shade800,
                            dismissDirection: DismissDirection.startToEnd,
                            behavior: SnackBarBehavior.floating,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.error, color: Colors.white),
                                SizedBox(width: 25,),
                                Text(
                                  'Erro: não foi possível deletar a notícia!',
                                  style: TextStyle(
                                    fontFamily: 'San Francisco'
                                  ),
                                ),
                              ],
                            ),
                          )
                        );
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Deletar'
                  ),

                  SlidableAction(
                    backgroundColor: const Color.fromARGB(255, 177, 113, 219),
                    foregroundColor: Colors.white,
                    icon: Icons.copy_outlined,
                    label: 'Copiar link',
                    onPressed: (context) async {
                      await Clipboard.setData(
                        ClipboardData(
                          text: _removeQuotationMarks(_bookmarks[index].link!),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color.fromARGB(255, 177, 113, 219),
                            dismissDirection: DismissDirection.startToEnd,
                            behavior: SnackBarBehavior.floating,
                            content: Row(
                              children: const [
                                Icon(Icons.copy, color: Colors.white,),
                                SizedBox(width: 25,),
                                Text(
                                  'Copiado para a área de transferência!',
                                  style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                  ),
                ],
              ),
              child: _bookmarksListView[index],
            );
          },
        ),
    );
  }

  _setListView() async {
    _bookmarks = await BookmarkedPostsController().getAllList();
    
    setState(() {
      try {
        _bookmarksListView = _bookmarks.map((data) {
          return ListTile(
            title: title(_removeQuotationMarks(data.title.toString())),
            subtitle: subtitle(_removeQuotationMarks(data.subtitle.toString())),
            leading: thumbnail(_removeQuotationMarks(data.imageUrl.toString())),
            trailing: const Icon(Icons.keyboard_arrow_right),
            contentPadding: const EdgeInsets.all(5.0),
            onTap: () => openFeed(_removeQuotationMarks(data.link.toString())),
          );
        }).toList();
      } catch (_) {}
    });
  }

  _deleteBookmark (int id) {
    BookmarkedPostsController().delete(id);
    setState(() {
      _setListView();
    });
  }

  _removeQuotationMarks (String text) {
    int firstQuote = text.indexOf('\'');
    int lastQuote = text.lastIndexOf('\'');
    
    return text.substring(firstQuote + 1, lastQuote);
  }

  Text title (String? title) {
    return Text(
      title ?? '',
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text subtitle (String? subtitle) {
    return Text(
      subtitle ?? '',
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w100,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Padding thumbnail (String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: imageUrl != null ? CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
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
    );
  }

  Future<void> openFeed (String url) async {
    final Uri uri = Uri.parse(url);
    
    if(!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro ao carregar.'),
            content: const Text('Tente novamente mais tarde.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
    }
  }
}