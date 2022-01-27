import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart' as http;

class CategoryServiceAPI {
  var client = http.Client();

  Future<List<dynamic>?> getAll() async {
    var url = '$localHost/category-service/all';

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
