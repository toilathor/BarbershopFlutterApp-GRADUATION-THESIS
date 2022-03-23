import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_model.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/item_service.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SelectServiceView extends StatefulWidget {
  final BookingModel model;

  const SelectServiceView({Key? key, required this.model}) : super(key: key);

  @override
  _SelectServiceViewState createState() => _SelectServiceViewState();
}

class _SelectServiceViewState extends State<SelectServiceView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> categoryServices = [
    'Hair cut/styling',
    'Hair dying',
    'Curling hair',
    'More'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<BookingModel>(
      onModelReady: (model) async {
        tabController =
            TabController(length: categoryServices.length, vsync: this);

        model.changeServices();
      },
      builder: (context, model, child) => DefaultTabController(
        length: categoryServices.length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: CupertinoNavigationBarBackButton(
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: TabBar(
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              controller: tabController,
              automaticIndicatorColorAdjustment: true,
              tabs: _buildTabBard(),
            ),
            title: const Text("Select Service"),
          ),
          body: Stack(
            children: [
              TabBarView(
                  children: _buildTabBarView(size, model),
                  controller: tabController),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: size.height * 0.08,
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).backgroundColor,
                    child: ElevatedButtonIcon(
                      onPressed: () {
                        Navigator.of(context)
                            .pop({'services': model.selectedServices});
                      },
                      title: model.selectedServices.isEmpty
                          ? 'Select service'.toUpperCase()
                          : 'Select ${model.selectedServices.length} service'
                              .toUpperCase(),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBard() {
    List<Widget> tabs = [];
    for (int i = 0; i < categoryServices.length; i++) {
      tabs.add(Tab(
        text: categoryServices[i],
      ));
    }
    return tabs;
  }

  List<Widget> _buildTabBarView(Size size, BookingModel model) {
    final paddingW = size.width * 0.01;

    List<Widget> tabBarViews = [];
    for (int i = 0; i < categoryServices.length; i++) {
      // tabBarViews.add(
      //   Container(),
      // );
      tabBarViews.add(
        MasonryGridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: paddingW,
            right: paddingW,
            top: paddingW,
            bottom: size.height * 0.1,
          ),
          crossAxisSpacing: paddingW,
          mainAxisSpacing: paddingW,
          itemCount: model.services[i].length,
          gridDelegate: const SliverMasonryGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final serviceCut = model.services[i][index];

            return ItemService(
              isSelected: model.selectedServices.contains(serviceCut),
              onPressSelect: () {
                model.changeSelectedServices(serviceCut);
              },
              onPressInfo: () {
                //TODO: Go to Info Service
              },
              width: size.width / 2,
              height: size.height / 2.7,
              serviceCut: serviceCut,
            );
          },
        ),
      );
    }
    return tabBarViews;
  }
}
