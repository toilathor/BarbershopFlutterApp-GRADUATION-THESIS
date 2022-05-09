import 'dart:async';

import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';

class AuthenticationService {
  final _api = locator<Api>();
  final _storeSecure = locator<StoreSecure>();

  StreamController<MUser> userController = StreamController<MUser>();

  final _userResponse = StreamController<MUser>.broadcast();

  Stream<MUser> get userResponse => _userResponse.stream;

  Function(MUser) get addUserResponse => _userResponse.sink.add;

  MUser user = MUser.initial();

  Future<bool> checkUserExist({required String phoneNumber}) async {
    var res = await _api.checkUserExist(phoneNumber: phoneNumber);

    if (res != null) {
      return res.data;
    }

    return false;
  }

  Future<bool> loginWithPhoneNumber({
    required String phoneNumber,
    required String password,
  }) async {
    var res = await _api.loginWithPhoneNumber(
      phoneNumber: phoneNumber,
      password: password,
    );

    if (res != null) {
      await saveSession(
        token: res.data['token'],
        expiresIn: res.data['expires_in'],
      );
      return true;
    }

    return false;
  }

  Future<bool> loginWithFacebook({
    required String name,
    String email = "",
    required String providerId,
  }) async {
    var res = await _api.loginWithFacebook(
      data: {'name': name, 'email': email, 'provider_id': providerId},
    );

    if (res != null) {
      await saveSession(
        token: res.data['token'],
        expiresIn: res.data['expires_in'],
      );
      return true;
    }

    return false;
  }

  Future<bool> loginWithGoogle({
    required String name,
    String email = "",
    required String providerId,
  }) async {
    var res = await _api.loginWithGoogle(
      data: {'name': name, 'email': email, 'provider_id': providerId},
    );

    if (res != null) {
      await saveSession(
        token: res.data['token'],
        expiresIn: res.data['expires_in'],
      );
      return true;
    }

    return false;
  }

  Future<bool> register({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    var res = await _api.register(
      data: {
        'phone_number': phoneNumber,
        'name': name,
        'password': password,
      },
    );

    if (res != null && res.data) {
      return true;
    }

    return false;
  }

  Future<bool> logOut() async {
    var res = await _api.logOut();

    if (res != null && res.data) {
      await _storeSecure.setToken(null);
      await _storeSecure.setExpiresIn(null);

      user = MUser.initial();

      addResponseUser(user);
      return true;
    }
    return false;
  }

  Future saveSession({required String token, required String expiresIn}) async {
    _api.setToken(token);

    await _storeSecure.setToken(token);

    await _storeSecure.setExpiresIn(expiresIn);

    _api.setToken(token);

    await getMe();
  }

  Future getMe() async {
    var res = await _api.getMe();

    if (res != null) {
      user = MUser.fromJson(res.data);
      addResponseUser(user);
    }
  }

  addResponseUser(MUser user) {
    addUserResponse(user);
  }
}
