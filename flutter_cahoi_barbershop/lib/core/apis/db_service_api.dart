import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart' as http;

class DBServiceAPI {
  var client = http.Client();

  Future<List<dynamic>?> getByCategoryServiceId(int categoryServiceId) async {
    var url = '$localHost/service/$categoryServiceId';

    http.Response response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
