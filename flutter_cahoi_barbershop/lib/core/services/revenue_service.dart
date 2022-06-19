import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/revenue.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class RevenueService {
  final _api = locator<Api>();

  Future<List<Revenue>> getRevenueMonth({
    required int addMonth,
  }) async {
    var res = await _api.getRevenueMonth(
      data: {
        "add_month": addMonth,
      },
    );

    if (res != null) {
      return List<Revenue>.from(
        res.data.map((e) => Revenue.fromJson(e)).toList(),
      );
    }

    return [];
  }

  Future<bool> paid(int revenueId) async {
    var res = await _api.paid(
      data: {
        "revenue_id": revenueId,
      },
    );

    if (res != null) {
      return res.data;
    }

    return false;
  }

  Future fetchTotalMonth() async {
    await _api.fetchTotalMonth();
  }
}
