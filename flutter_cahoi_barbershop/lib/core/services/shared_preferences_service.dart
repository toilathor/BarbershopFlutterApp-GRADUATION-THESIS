import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final keyLoginWithSocial = 'LOGIN_WITH_SOCIAL';
  SharedPreferences? prefs;

  SharedPreferencesService() {
    getInstance();
  }

  setSocial(TypeSocial typeSocial) async {
    // await getInstance();

    prefs?.setInt(keyLoginWithSocial, typeSocial.index);
  }

  int getSocial()  {
    // await getInstance();

    return prefs?.getInt(keyLoginWithSocial) ?? 0;
  }

  getInstance() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    } else {
      return;
    }
  }
}
