import 'package:flutter/material.dart';
import 'package:mitech/pages/basics/basics.dart';
import 'package:mitech/pages/bookmarks/bookmarks.dart';
import 'package:mitech/pages/feed/feed.dart';
import 'package:mitech/pages/search/search_page.dart';
import 'package:mitech/pages/info/info_page.dart';

class BarraNavegacao extends StatefulWidget {
  const BarraNavegacao({Key? key}) : super(key: key);

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao> {
  int _currentIndex = 2;
  List<Widget> pages = [
    const Bookmarks(),
    const Basics(),
    const Feed(),
    const SearchPage(),
    const InfoPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF8AA868).withOpacity(0.5),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.bookmarks_outlined),
              selectedIcon: Icon(Icons.bookmarks),
              label: 'Salvos',
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category),
              label: 'Básico',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper_outlined),
              selectedIcon: Icon(Icons.newspaper),
              label: 'Notícias',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search),
              label: 'Procurar'
            ),
            NavigationDestination(
              icon: Icon(Icons.info_outlined),
              selectedIcon: Icon(Icons.info),
              label: 'Info.',
            ),
          ],
        ),
      ),
    );
  }
}