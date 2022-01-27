import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';

class SelectServiceProvider extends ChangeNotifier {
  bool _disposed = false;
  List<ServiceCut> selectedServices = [];

  init(List<ServiceCut> selectedServices) {
    this.selectedServices = selectedServices;
    notifyListeners();
  }

  changeSelectedServices(ServiceCut item) {
    if (!selectedServices.contains(item)) {
      selectedServices.removeWhere(
              (element) => item.categoryServiceId == element.categoryServiceId);
      selectedServices.add(item);
    } else {
      selectedServices.remove(item);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
