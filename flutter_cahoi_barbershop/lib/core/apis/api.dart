import 'package:date_format/date_format.dart' as date_format;
import 'package:flutter_cahoi_barbershop/core/models/response.dart' as api_res;
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

import '_base.dart';

class Api extends ApiBase {
  Api() {
    super.baseApi();
  }

  ///Auth
  Future<api_res.Response?> checkUserExist(
      {required String phoneNumber}) async {
    try {
      var res = await dio.get('/user/check-exist', queryParameters: {
        "phone_number": phoneNumber,
      });
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getMe() async {
    try {
      var res = await dio.get('/user/me');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> loginWithPhoneNumber(
      {required String phoneNumber, required String password}) async {
    try {
      var res = await dio.post('/auth/login/phone-number',
          data: {"phone_number": phoneNumber, "password": password});
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> register(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/auth/register', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> loginWithGoogle(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/auth/login/google', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> loginWithFacebook(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/auth/login/facebook', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> logOut() async {
    try {
      var res = await dio.get('/auth/logout');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Booking
  Future<api_res.Response?> getFacility() async {
    try {
      var res = await dio.get('/facilities');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getStylists(
      {required int facilityId, required DateTime date}) async {
    try {
      var res = await dio.get('/stylist/$facilityId',
          queryParameters: {"date": date_format.formatDate(date, formatDate)});
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Product
  Future<api_res.Response?> getTypeProduct() async {
    try {
      var res = await dio.get('/type-products');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getProduct({required int typeProductId}) async {
    try {
      var res = await dio.get('/product/$typeProductId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getRating({required int stylistId}) async {
    try {
      var res = await dio.get('/stylist/rating/$stylistId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getTimeSlot() async {
    try {
      var res = await dio.get('/time-slot');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  getTimeSlotSelected({
    required int stylistId,
    required String date,
  }) async {
    try {
      var res = await dio.get(
        '/time-slot/$stylistId',
        queryParameters: {"date": date},
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> createNewTask({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.post(
        '/task',
        data: data,
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
