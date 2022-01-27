import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist/stylist.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart';

class EmployeeAPI {
  final client = Client();

  Future<List<Stylist>?> getStylist(int workplaceId) async {
    final url = '$localHost/employee/stylist/$workplaceId';
    var response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return List<Stylist>.from(json.map((i) => Stylist.fromJson(i)));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return [];
  }
}
