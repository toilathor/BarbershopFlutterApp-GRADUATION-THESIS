import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/rating.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/time_slot.dart';
import 'package:flutter_cahoi_barbershop/core/models/type_product.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class BookingService {
  final Api _api = locator<Api>();

  ///Facility
  Future<Position?> getCurrentLocation() async {
    var status = await Permission.location.status;

    await Permission.location.request();

    if (status.isPermanentlyDenied) {
      await Permission.location.request();
      openAppSettings();
    }

    if (status.isDenied) {
      await Permission.location.request();
    }

    if (status.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }

    return null;
  }

  Future<List<Facility>> getFacility() async {
    var response = await _api.getFacility();

    if (response != null) {
      return List<Facility>.from(
        response.data.map((i) => Facility.fromJson(i)).toList(),
      );
    }

    return [];
  }

  //Service
  Future<List<Product>> getProduct({required int typeProductId}) async {
    var res = await _api.getProduct(typeProductId: typeProductId);

    if (res != null) {
      return List<Product>.from(
          res.data.map((i) => Product.fromJson(i)).toList());
    }

    return [];
  }

  Future<List<TypeProduct>> getTypeProduct() async {
    var res = await _api.getTypeProduct();

    if (res != null) {
      return List<TypeProduct>.from(
        res.data.map((i) => TypeProduct.fromJson(i)).toList(),
      );
    }

    return [];
  }

  //Stylist
  Future<List<Stylist>> getStylists(
      {required int facilityId, required DateTime date}) async {
    var response = await _api.getStylists(facilityId: facilityId, date: date);

    if (response != null) {
      return List<Stylist>.from(
          response.data.map((i) => Stylist.fromJson(i)).toList());
    }

    Fluttertoast.showToast(msg: "error");
    return [];
  }

  Future<Rating> getRating({required int stylistId}) async {
    var res = await _api.getRating(stylistId: stylistId);

    if (res != null) {
      return Rating.fromJson(res.data);
    }

    Fluttertoast.showToast(msg: "error");
    return Rating(avgCommunicationRate: '0', avgSkillRate: '0');
  }

  Future<List<TimeSlot>> getTimeSlot() async {
    var res = await _api.getTimeSlot();

    if (res != null) {
      return List<TimeSlot>.from(
          res.data.map((i) => TimeSlot.fromJson(i)).toList());
    }

    Fluttertoast.showToast(msg: "error");
    return [];
  }

  Future<List<TimeSlot>> getTimeSlotSelected({
    required int stylistId,
    required String date,
  }) async {
    var res = await _api.getTimeSlotSelected(
      stylistId: stylistId,
      date: date,
    );

    if (res != null) {
      return List<TimeSlot>.from(
          res.data.map((i) => TimeSlot.fromJson(i)).toList());
    }

    Fluttertoast.showToast(msg: "error");
    return [];
  }

  Future<bool> createNewTask({
    required Map<String, dynamic> data,
  }) async {
    var res = await _api.createNewTask(data: data);
    if (res != null) {
      return res.data;
    }
    return false;
  }

  Future<Facility?> findFacility({required int userId}) async {
    var res = await _api.findFacility(data: {
      "user_id" : userId
    });

    if(res != null && res.data != null) {
      return Facility.fromJson(res.data);
    }

    return null;
  }
}
