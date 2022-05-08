import 'dart:convert';

import 'package:admin/core/apis/response.dart' as apiRes;
import 'package:dio/dio.dart';

class ApiBase {
  var options = BaseOptions(
    baseUrl: 'http://144.202.101.144:4000/api/v1',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  late Dio dio;
  late String token;

  baseAPI() {
    dio = Dio(options);
    dio.options.headers['content-Type'] = 'application/json';
  }

  // var client = new Client();
  setToken(String bearerToken) async {
    token = bearerToken;
    dio.options.headers["authorization"] = "Bearer " + bearerToken;
    return;
  }

  apiRes.Response castRes(Response res) {
    Map<String, dynamic> json = jsonDecode(res.toString());
    return apiRes.Response.fromJson(json);
  }
}
