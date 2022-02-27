import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:geolocator/geolocator.dart';

class BookingService {
  final Api _api = locator<Api>();

  //WorkPlace
  Future<Position> getCurrentLocation() async {
    var locationPermission = await Geolocator.checkPermission();

    if (LocationPermission.denied == locationPermission) {
      await Geolocator.requestPermission();
    } else if (LocationPermission.deniedForever == locationPermission) {
      await Geolocator.openLocationSettings();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Workplace>?> getWorkPlace() async {
    var response = await _api.getAllWorkPlace();

    if (response != null) {
      return List<Workplace>.from(
          response.data.map((i) => Workplace.fromJson(i)).toList());
    }

    return null;
  }

  //Service
  Future<List<ServiceCut>?> getService({required int categoryServiceId}) async {
    var response = await _api.getService(categoryServiceId: categoryServiceId);

    if (response != null) {
      return List<ServiceCut>.from(
          response.data.map((i) => ServiceCut.fromJson(i)).toList());
    }

    return null;
  }

  //Stylist
  Future<List<Stylist>?> getStylists({required int workplaceId}) async{
    var response = await _api.getStylists(workplaceId: workplaceId);

    if (response != null) {
      return List<Stylist>.from(
          response.data.map((i) => Stylist.fromJson(i)).toList());
    }

    return null;
  }
}
