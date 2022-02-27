import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_model.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/item_workplace.dart';
import 'package:geolocator/geolocator.dart';

class SelectBarbershopView extends StatefulWidget {
  const SelectBarbershopView({Key? key}) : super(key: key);

  @override
  _SelectBarbershopViewState createState() => _SelectBarbershopViewState();
}

class _SelectBarbershopViewState extends State<SelectBarbershopView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BookingModel>(
      onModelReady: (model) async {
        await model.changeWorkplaces();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Select Barbershop"),
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        body: model.workplaces == null
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
            : (model.workplaces!.isEmpty || model.position == null
                ? const Center(
                    child: Text('Sad!'),
                  )
                : ListView.builder(
                    itemCount: model.workplaces!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ItemWorkplace(
                      workplace: model.workplaces![index],
                      isFirst: index == 0,
                      distance: Geolocator.distanceBetween(
                          model.position!.latitude,
                          model.position!.longitude,
                          model.workplaces![index].latitude,
                          model.workplaces![index].longitude),
                      onPress: () {
                        model.changeWorkplace(model.workplaces![index]);
                        Navigator.of(context)
                            .pop({'selection': model.workplaces![index]});
                      },
                    ),
                  )),
      ),
    );
  }
}
