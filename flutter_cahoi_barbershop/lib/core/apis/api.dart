import 'package:date_format/date_format.dart' as date_format;
import 'package:dio/src/form_data.dart';
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
      var res = await dio.get('/stylist/facility/$facilityId',
          queryParameters: {"date": date_format.formatDate(date, fDate)});
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

  Future<api_res.Response?> getAllProduct() async {
    try {
      var res = await dio.get('/product');
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

  Future<api_res.Response?> getTimeSlot() async {
    try {
      var res = await dio.get('/time-slot');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getTimeSlotSelected({
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

  ///Task
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

  Future<api_res.Response?> getDetailTask(
      {required Map<String, int> data}) async {
    try {
      var res = await dio.get(
        '/task/detail',
        queryParameters: data,
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> searchTask(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.get(
        '/task',
        queryParameters: data,
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> updateTaskStatus({
    // required Map<String, dynamic> data,
    required FormData data,
  }) async {
    try {
      var res = await dio.post(
        '/task/update-status',
        data: data,
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///User
  Future<api_res.Response?> searchUser(Map<String, dynamic> data) async {
    try {
      var res = await dio.get(
        '/user/search',
        queryParameters: data,
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> checkPassword(
      {required Map<String, String> data}) async {
    try {
      var res = await dio.post('/user/check-password', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> changePassword(
      {required Map<String, String> data}) async {
    try {
      var res = await dio.post('/user/change-password', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Role
  Future<api_res.Response?> getRoles() async {
    try {
      var res = await dio.get(
        '/role/except',
      );
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> syncRole(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/role/sync-role', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> findFacility(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.get('/facility/stylist', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getTaskHistory(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.get('/task/customer/history', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Post
  Future<api_res.Response?> sharePost(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/post', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getPost({required Map<String, int> data}) async {
    try {
      var res = await dio.get('/post/in-month', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> getWall({required Map<String, int> data}) async {
    try {
      var res = await dio.get('/post/wall', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> likePost({required Map<String, int> data}) async {
    try {
      var res = await dio.post('/post/like', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> cancelTask(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.delete('/task', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> deletePost(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.delete('/post', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> updatePost(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/post/edit', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
