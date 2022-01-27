import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/select_service_provider.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/item_service.dart';
import 'package:flutter_cahoi_barbershop/ui/widgets/elevated_button_icon.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SelectServiceView extends StatefulWidget {
  final BookingProvider model;

  const SelectServiceView({Key? key, required this.model}) : super(key: key);

  @override
  _SelectServiceViewState createState() => _SelectServiceViewState();
}

class _SelectServiceViewState extends State<SelectServiceView>
    with SingleTickerProviderStateMixin {
  final selectServiceProvider = locator<SelectServiceProvider>();
  final bookingProvider = locator<BookingProvider>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    selectServiceProvider.init(bookingProvider.selectedServices);
    tabController = TabController(
        length: bookingProvider.categoryServices.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookingProvider>.value(
          value: bookingProvider,
        ),
        ChangeNotifierProvider<SelectServiceProvider>(
          create: (context) => selectServiceProvider,
        )
      ],
      child: DefaultTabController(
        length: bookingProvider.categoryServices.length,
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
                  children: _buildTabBarView(size), controller: tabController),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height * 0.08,
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).backgroundColor,
                    child: Consumer<SelectServiceProvider>(
                      builder: (context, value, child) => ElevatedButtonIcon(
                        onPressed: () {
                          bookingProvider.setSelectedService(
                              selectServiceProvider.selectedServices);
                          if (bookingProvider.selectedServices.isNotEmpty) {
                            bookingProvider.nextStep();
                          }
                          Navigator.of(context).pop();
                        },
                        title: value.selectedServices.isEmpty
                            ? 'Select service'.toUpperCase()
                            : 'Select ${value.selectedServices.length} service'
                                .toUpperCase(),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBard() {
    List<Widget> tabs = [];
    for (int i = 0; i < bookingProvider.categoryServices.length; i++) {
      tabs.add(Tab(
        text: bookingProvider.categoryServices[i].name,
      ));
    }
    return tabs;
  }

  List<Widget> _buildTabBarView(Size size) {
    final paddingW = size.width * 0.01;

    List<Widget> tabBarViews = [];
    for (int i = 0; i < bookingProvider.categoryServices.length; i++) {
      tabBarViews.add(
        Consumer<SelectServiceProvider>(
          builder: (context, value, child) => MasonryGridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: paddingW,
              right: paddingW,
              top: paddingW,
              bottom: size.height * 0.1,
            ),
            crossAxisSpacing: paddingW,
            mainAxisSpacing: paddingW,
            itemCount: bookingProvider.categoryServices[i].serviceCuts?.length,
            gridDelegate:
                const SliverMasonryGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final serviceCut =
                  bookingProvider.categoryServices[i].serviceCuts![index];

              return Consumer<SelectServiceProvider>(
                builder: (context, value, child) => ItemService(
                    isSelected: value.selectedServices.contains(serviceCut),
                    onPressSelect: () {
                      value.changeSelectedServices(serviceCut);
                    },
                    onPressInfo: () {
                      //TODO: Go to Info Service
                    },
                    width: size.width / 2,
                    height: size.height / 2.7,
                    serviceCut: serviceCut),
              );
            },
          ),
        ),
      );
    }
    return tabBarViews;
  }
}
