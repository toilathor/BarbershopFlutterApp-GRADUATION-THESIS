import 'package:flutter_cahoi_barbershop/core/models/revenue.dart';
import 'package:flutter_cahoi_barbershop/core/services/revenue_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/core/view_state.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CollectMoneyModel extends BaseModel {
  final _revenueService = locator<RevenueService>();

  Map<String, double> dataChartFirst = {};
  Map<String, double> dataChartSecond = {};

  List<Revenue> revenueFirst = [];
  List<Revenue> revenueSecond = [];

  Future changeRevenueMonth(bool isFirstTab) async {
    setState(ViewState.busy);

    var res = await _revenueService.getRevenueMonth(
      addMonth: isFirstTab ? 0 : -1,
    );

    isFirstTab ? (revenueFirst = res) : (revenueSecond = res);

    setState(ViewState.idle);
    notifyListeners();
  }

  changeDataChart() {
    for (var e in revenueFirst) {
      dataChartFirst["${e.facility!.address}".split(',').first] = double.parse(
        "${e.totalRevenueMonth ?? 0}",
      );
    }
    for (var e in revenueSecond) {
      dataChartSecond["${e.facility!.address}".split(',').first] = double.parse(
        "${e.totalRevenueMonth ?? 0}",
      );
    }

    notifyListeners();
  }

  Future paid({int? revenueId}) async {
    if (revenueId == null) {
      return;
    } else {
      if (await _revenueService.paid(revenueId)) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "Đã ghi lại!");
        revenueSecond
            .firstWhere(
              (element) => element.id == revenueId,
            )
            .isPaid = 1;

        notifyListeners();
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "Lỗi!");
      }
    }
  }

  Future fetchTotalMonth() async {
    await _revenueService.fetchTotalMonth();
  }
}
