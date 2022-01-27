import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/select_barbershop_provider.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/item_workplace.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class SelectBarbershopView extends StatefulWidget {
  const SelectBarbershopView({Key? key}) : super(key: key);

  @override
  _SelectBarbershopViewState createState() => _SelectBarbershopViewState();
}

class _SelectBarbershopViewState extends State<SelectBarbershopView> {
  final selectBarbershopProvider = locator<SelectBarbershopProvider>();
  final bookingProvider = locator<BookingProvider>();

  @override
  void initState() {
    selectBarbershopProvider.changeWorkplace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookingProvider>.value(
          value: bookingProvider,
        ),
        ChangeNotifierProvider<SelectBarbershopProvider>(
          create: (context) => selectBarbershopProvider,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Barbershop"),
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        body: Consumer<SelectBarbershopProvider>(
          builder: (context, value, child) => value.workplaces == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Loading...',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                )
              : (value.workplaces!.isEmpty || value.position == null
                  ? const Center(
                      child: Text('Sad!'),
                    )
                  : ListView.builder(
                      itemCount: value.workplaces!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ItemWorkplace(
                        workplace: value.workplaces![index],
                        isFirst: index == 0,
                        distance: Geolocator.distanceBetween(
                            selectBarbershopProvider.position!.latitude,
                            selectBarbershopProvider.position!.longitude,
                            value.workplaces![index].latitude,
                            value.workplaces![index].longitude),
                        onPress: () {
                          bookingProvider.nextStep();
                          bookingProvider
                              .changeWorkplace(value.workplaces![index]);
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
        ),
      ),
    );
  }
}
