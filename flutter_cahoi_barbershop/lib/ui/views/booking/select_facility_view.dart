import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/views/_base.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/widgets/facility_tile.dart';
import 'package:geolocator/geolocator.dart';

class SelectFacilityView extends StatefulWidget {
  const SelectFacilityView({Key? key}) : super(key: key);

  @override
  _SelectFacilityViewState createState() => _SelectFacilityViewState();
}

class _SelectFacilityViewState extends State<SelectFacilityView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BookingModel>(
      onModelReady: (model) async {
        await model.changeFacilities();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            appLang(context)!.select_facility,
          ),
          automaticallyImplyLeading: false,
          leading: CupertinoNavigationBarBackButton(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        body: model.facilities.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      appLang(context)!.loading,
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
              )
            : (model.facilities.isEmpty || model.position == null
                ? Center(
                    child: Text(
                      appLang(context)!.has_error,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await model.changeFacilities();
                    },
                    child: ListView.builder(
                      itemCount: model.facilities.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => FacilityTile(
                        facility: model.facilities[index],
                        isFirst: index == 0,
                        distance: Geolocator.distanceBetween(
                            model.position!.latitude,
                            model.position!.longitude,
                            model.facilities[index].latitude ?? 0,
                            model.facilities[index].longitude ?? 0),
                        onPress: () {
                          Navigator.of(context).pop(
                            {'selection': model.facilities[index]},
                          );
                        },
                      ),
                    ),
                  )),
      ),
    );
  }
}
