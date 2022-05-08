import 'package:flutter_cahoi_barbershop/core/apis/_base.dart';
import 'package:flutter_cahoi_barbershop/core/models/response.dart' as api_res;
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';

class Api extends ApiBase {
  Api() {
    super.baseApi();
  }

  ///Auth
  Future<api_res.Response?> checkUserExist(
      {required String phoneNumber}) async {
    try {
      var res = await dio.get('/auth/check-user/$phoneNumber');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> loginWithPhoneNumber(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/auth/login-phone-number', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  Future<api_res.Response?> loginWithSocials(
      {required Map<String, dynamic> data,
      required TypeSocial typeSocial}) async {
    try {
      var res =
          await dio.post('/auth/login-socials/${typeSocial.name}', data: data);
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

  Future<api_res.Response?> resetPassword(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post('/auth/reset-password', data: data);
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Category
  Future<api_res.Response?> getAllCategory() async {
    try {
      var res = await dio.get('/category-service/all');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Product
  Future<api_res.Response?> getService({required int categoryServiceId}) async {
    try {
      var res = await dio.get('/service/$categoryServiceId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  ///Employee
  Future<api_res.Response?> getStylists({required int workplaceId}) async {
    try {
      var res = await dio.get('/employee/stylist/$workplaceId');
      return castRes(res);
    } catch (e) {
      return null;
    }
  }

  //Workplace
  Future<api_res.Response?> getAllWorkPlace() async {
    try {
      var res = await dio.get('/workplace/all');

      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
