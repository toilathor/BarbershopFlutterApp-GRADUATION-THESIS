import 'package:date_format/date_format.dart' as date_format;
// ignore: implementation_imports
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
  Future<api_res.Response?> checkCanBook() async {
    try {
      var res = await dio.get('/task/can-book');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

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

  Future<api_res.Response?> getDiscounts({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.get('/discount/code', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> addDiscountTask({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.post('/task/add-voucher', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> removeDiscountTask({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.delete('/task/delete-voucher', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> changeSumSpent() async {
    try {
      var res = await dio.get('/bill/spent-last-6-months');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///User
  Future<api_res.Response?> fetch() async {
    try {
      var res = await dio.get('/user/fetch');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

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

  Future<api_res.Response?> changeAvatar({required FormData data}) async {
    try {
      var res = await dio.post('/user/change-avatar', data: data);
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

  Future<api_res.Response?> getPostLastMonth() async {
    try {
      var res = await dio.get('/post/last-month');
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

  // Rating
  Future<api_res.Response?> getRatingTask({required taskId}) async {
    try {
      var res = await dio.get('/rating/$taskId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> saveRating({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.post('/rating', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  /// Product
  Future<api_res.Response?> createProduct({required FormData data}) async {
    try {
      var res = await dio.post('/product', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> updateProduct(
      {required FormData data, required int productId}) async {
    try {
      var res = await dio.post('/product/edit/$productId', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> deleteProduct({required int productId}) async {
    try {
      var res = await dio.delete('/product/$productId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> signCalender() async {
    try {
      var res = await dio.get('/');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  /// Revenue
  Future<api_res.Response?> getRevenueMonth({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await dio.get('/revenue', queryParameters: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> paid({required Map<String, int> data}) async {
    try {
      var res = await dio.post('/revenue/paid', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> fetchTotalMonth() async {
    try {
      var res = await dio.get('/revenue/fetch');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
