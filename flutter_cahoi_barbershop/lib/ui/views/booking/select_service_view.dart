import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/service_tab.dart';
import 'package:provider/provider.dart';

class SelectServiceView extends StatefulWidget {
  const SelectServiceView({Key? key}) : super(key: key);

  @override
  _SelectServiceViewState createState() => _SelectServiceViewState();
}

class _SelectServiceViewState extends State<SelectServiceView>
    with SingleTickerProviderStateMixin {
  final model = locator<BookingModel>();
  late TabController tabServiceController;

  @override
  void initState() {
    super.initState();
    tabServiceController = TabController(
      length: model.categoryServices.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<BookingModel>(
      create: (context) => model,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
          title: const Text("Select Service"),
          actions: [
            Container(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                      (route) => false);
                },
                icon: Icon(
                  Icons.home,
                  size: Theme.of(context).iconTheme.size ?? 24,
                ),
                tooltip: 'Home',
              ),
            )
          ],
        ),
        body: DefaultTabController(
          length: model.categoryServices.length,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: tabServiceController,
                    indicatorColor: textColorLight2,
                    tabs: _buildTabBar(),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabServiceController,
                      children: _buildTabBarView(),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height * 0.08,
                    color: Theme.of(context).backgroundColor,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Select")),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBar() {
    List<Tab> tabs = [];
    for (int i = 0; i < model.categoryServices.length; i++) {
      tabs.add(Tab(
        child: Text(model.categoryServices[i].name,
            style: Theme.of(context).textTheme.headline3),
      ));
    }
    return tabs;
  }

  List<Widget> _buildTabBarView() {
    List<ServiceTab> tabViews = [];
    for (int i = 0; i < model.categoryServices.length; i++) {
      tabViews.add(ServiceTab(
        serviceCuts: model.serviceCuts,
        onPress: () {},
      ));
    }
    return tabViews;
  }
}
