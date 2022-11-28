import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mitech/controllers/bookmarked_posts_controller.dart';
import 'package:mitech/models/bookmarked_posts_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);
  final String title = 'Últimas atualizações';

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  /* static Uri feedUrl = Uri(
    /* 'https://nasa.gov/rss/dyn/lg_image_of_the_day.rss' */
    scheme: 'https',
    host: 'rss.tecmundo.com.br',
    path: 'feed'
  ); */
  
  
  //static const String loadingFeedMsg = 'Loading feed...';
  //static const String feedLoadErrorMsg = 'Error loading feed';
  //static const String feedOpenErrorMsg = 'Error opening feed';
  static const String placeholderImg = 'assets/images/noImage.jpg';
  bool hasItAlreadyLoaded = false;
  
  late GlobalKey<RefreshIndicatorState> _refreshKey;

  List<Uri> feedURIs = [
    Uri(
      scheme: 'https',
      host: 'rss.tecmundo.com.br',
      path: 'feed'
    ),
  ];

  List<RssFeed> feeds = [];

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    initializeFeed();
  }

  Future<void> initializeFeed() async {
    await loadFeed();
    load();
    setState(() {
      hasItAlreadyLoaded = true;
    });
  }

  shareLink(link) {
    Share.share(_removeQuotationMarks(link));
  }

  // GETTING THE FEED
  Future<List<RssFeed>?> loadFeed() async {
    try {
      final client = http.Client();
      
      for (Uri uri in feedURIs) {
        final response = await client.get(uri);
        feeds.add(RssFeed.parse(response.body));
      }

      return feeds;
    } catch (e) {
      //
    }
    return null;
  }

  load() async {
    //updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        return showDialog(
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
      updateFeed(result);
      //updateTitle(_feed.title);
    });
  }

  updateFeed(feed) {
    setState(() {
      feeds = feed;
    });
  }

  Future<void> openFeed (String url) async {
    final Uri uri = Uri.parse(url);
    if(!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      //updateTitle(feedOpenErrorMsg);
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

  _removeQuotationMarks (String text) {
    int firstQuote = text.indexOf('\'');
    int lastQuote = text.lastIndexOf('\'');
    
    return text.substring(firstQuote + 1, lastQuote);
  }

  Text title (title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      key: ValueKey('$title'),
    );
  }

  Text subtitle (subtitle) {
    return Text(
      subtitle ?? '',
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w100,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      key: ValueKey('$subtitle'),
    );
  }

  Padding thumbnail (imageUrl) {
    return Padding(
      key: ValueKey('$imageUrl'),
      padding: const EdgeInsets.only(left: 15.0),
      child: imageUrl != null ? CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 100,
        width: 100,
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ) :
      SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(placeholderImg),
      ),
    );
  }

  /* IconButton rightIcon () {
    Icon tapIcon = const Icon(Icons.bookmark_add_outlined);
    return IconButton(
      enableFeedback: true,
      onPressed: () {
        setState(() {
          tapIcon = const Icon(Icons.bookmark_added);
        });
      },
      icon: tapIcon,
      color: Colors.grey,
      );

    /* color: Colors.grey,
       size: 30.0, */
  } */

  Widget list () {
    List<ListTile> listagem = [];
    
    for (RssFeed f in feeds) {
      for (int i = 0; i < f.items!.length; i++) {
        final item = f.items![i];
        listagem.add(
          ListTile(
            key: ValueKey('${item.link}'),
            title: title(item.title),
            subtitle: subtitle(item.dc?.creator ?? 'No author'),
            leading: thumbnail(item.enclosure!.url),
            trailing: const Icon(Icons.keyboard_arrow_right),
            contentPadding: const EdgeInsets.all(5.0),
            onTap: () => openFeed(item.link ?? ''),
          )
        );
      }
    }

    if(listagem.isEmpty) {
      return const CircularProgressIndicator();
    }
    else {
      return ListView.builder(
      itemCount: listagem.length,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.bookmark_outline,
                label: 'Salvar',
                onPressed: (context) {
                  try {
                    BookmarkedPostsController().insert(
                      BookmarkedPostsModel(
                        null,
                        listagem[index].title?.key.toString(),
                        listagem[index].subtitle?.key.toString(),
                        listagem[index].leading?.key.toString(),
                        listagem[index].key.toString(), // the link's in this line
                      )
                    );
                    
                    print(listagem[index].key.toString());
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        dismissDirection: DismissDirection.startToEnd,
                        behavior: SnackBarBehavior.floating,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.bookmark_added, color: Colors.white,),
                            SizedBox(width: 25,),
                            Text(
                              'A notícia foi salva com sucesso!',
                              style: TextStyle(fontFamily: 'San Francisco',),
                            ),
                          ],
                        ),
                      )
                    );

                    print('Salvou!');
                  }
                  catch (_) {
                    print('Erro!');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        dismissDirection: DismissDirection.startToEnd,
                        behavior: SnackBarBehavior.floating,
                        content: Row(
                          children: const [
                            Icon(Icons.error, color: Colors.white,),
                            SizedBox(width: 25,),
                            Text(
                              'Erro: não foi possível salvar a notícia!',
                              style: TextStyle(
                                fontFamily: 'San Francisco'
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),

              SlidableAction(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                icon: Icons.share,
                label: 'Compartilhar',
                onPressed: (context) {
                  shareLink(listagem[index].key.toString());
                }
              ),
            ],
          ),
          child: listagem[index],
        );
      },
    );
    }

    /* ListView.builder(
          itemCount: f.items?.length,
          itemBuilder: (BuildContext context, int index ) { */
            
            //feeds.iterator.current.items!.iterator.current;
            //_feed.items![index];
            /* bool isSaved = false;
            Icon myIcon = Icon(Icons.bookmark_add_outlined); */
  }

  isFeedEmpty () {
    // return null == _feed || null == _feed.items;
    return null == feeds || null == feeds.first.items;
    /* if (_feed == null || _feed.items == null) {
      return true;
    } */
    /* for (var f in feeds) {
      return null == feeds || null == f.items || null == f;
    } */
  }

  Widget body () => isFeedEmpty() ?
    const Center(
      child: CircularProgressIndicator(),
    ) :
    RefreshIndicator(
      onRefresh: () => initializeFeed() /* load() */,
      key: _refreshKey,
      child: list(),
    );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimas atualizações'),
      ),
      body: hasItAlreadyLoaded ?
        body() :
        const Center(
          child: CircularProgressIndicator(),
        ),
    );
  }
}