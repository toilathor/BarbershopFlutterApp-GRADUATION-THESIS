import 'package:flutter_cahoi_barbershop/core/models/response.dart' as api_res;

import '_base.dart';

class Api2 extends ApiBase {
  Api2() {
    super.baseApi();
  }

  ///Auth
  Future<api_res.Response?> checkUserExist(
      {required String phoneNumber}) async {
    try {
      var res = await dio
          .post('/user/check-exist', data: {"phone_number": phoneNumber});
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

  Future<api_res.Response?> logOut()async {
    try {
      var res = await dio.get('/auth/logout');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
