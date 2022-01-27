import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    var locationPermission = await Geolocator.checkPermission();

    if (LocationPermission.denied == locationPermission ) {
      await Geolocator.requestPermission();
    }else if(LocationPermission.deniedForever == locationPermission){
      await Geolocator.openLocationSettings();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
