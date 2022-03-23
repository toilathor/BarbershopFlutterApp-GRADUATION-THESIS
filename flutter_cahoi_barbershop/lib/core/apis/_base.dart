import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cahoi_barbershop/core/models/response.dart' as api_res;
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';

class ApiBase {
  var options = BaseOptions(
    baseUrl: localHost,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  late Dio dio;

  baseApi() {
    dio = Dio(options);
    dio.options.headers['content-Type'] = 'application/json';
  }

  // var client = new Client();
  setToken(String bearerToken) async {
    dio.options.headers["authorization"] = "Bearer " + bearerToken;
    return;
  }

  api_res.Response castRes(Response res) {
    Map<String, dynamic> json = jsonDecode(res.toString());
    return api_res.Response.fromJson(json);
  }
}
