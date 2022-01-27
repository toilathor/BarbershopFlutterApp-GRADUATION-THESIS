import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:http/http.dart';

class WorkplaceAPI {
  final client = Client();

  Future<List<Workplace>?> getAll() async {
    var url = '$localHost/workplace/all';
    var response = await client.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return List<Workplace>.from(
            json.map((i) => Workplace.fromJson(i)).toList());
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }

    return [];
  }
}
