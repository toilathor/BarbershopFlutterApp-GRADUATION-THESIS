import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/account_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/discover_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/home_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/pages/story_page_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> _listPage = [
    const HomePageView(),
    const DiscoverPageView(),
    const StoryPageView(),
    const AccountPageView(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          children: _listPage,
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          iconSize: Theme.of(context).iconTheme.size ?? 24,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).iconTheme.color,
          unselectedItemColor: Theme.of(context).secondaryHeaderColor,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Discover"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu_rounded), label: 'Story'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Account"),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
