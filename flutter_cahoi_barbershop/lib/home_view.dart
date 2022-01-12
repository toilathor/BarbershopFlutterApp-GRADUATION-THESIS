import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/account_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/discover_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/home_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/shop_page_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/style_master_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> _listPage = [
    const HomePageView(),
    const DiscoverPageView(),
    const ShopPageView(),
    const StyleMasterPageView(),
    const AccountPageView(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _listPage[_currentIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: () async {
            if (await canLaunch("tel:$phoneNumber")) {
              await launch("tel:$phoneNumber");
            }
          },
          tooltip: 'Hotline',
          child: Icon(
            Icons.call,
            color: Theme.of(context).backgroundColor,
          ),
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
                icon: Icon(Icons.storefront), label: 'Shop'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.cut_sharp,
                ),
                label: "Style Master"),
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
