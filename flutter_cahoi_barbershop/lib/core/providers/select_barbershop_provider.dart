import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/workplace_api.dart';
import 'package:flutter_cahoi_barbershop/core/models/workplace/workplace.dart';
import 'package:flutter_cahoi_barbershop/core/services/geolocator_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:geolocator/geolocator.dart';

class SelectBarbershopProvider extends ChangeNotifier {
  final _geolocation = locator<GeolocatorService>();
  final _workplaseApi = locator<WorkplaceAPI>();

  bool _disposed = false;
  Position? position;
  List<Workplace>? workplaces;

  changePosition() async {
    position = await _geolocation.getCurrentLocation();
    notifyListeners();
  }

  changeWorkplace() async {
    await changePosition();
    workplaces = await _workplaseApi.getAll();
    workplaces!.sort(
      (a, b) => Geolocator.distanceBetween(
              position!.latitude, position!.longitude, a.latitude, a.longitude)
          .compareTo(
        Geolocator.distanceBetween(
            position!.latitude, position!.longitude, b.latitude, b.longitude),
      ),
    );
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
