import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/task_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await locator<TaskService>().cleanTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _listPage[_currentIndex],
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
          selectedLabelStyle: const TextStyle(fontFamily: fontBold),
          unselectedLabelStyle: const TextStyle(fontFamily: fontBold),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.search,
              ),
              label: appLang(context)!.bottombar_discovery,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history_edu_rounded),
              label: appLang(context)!.bottombar_story,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
              ),
              label: appLang(context)!.bottombar_menu,
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
