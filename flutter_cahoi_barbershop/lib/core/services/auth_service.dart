import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';

class AuthenticationService {
  final _api = locator<Api>();

  // final _userResponse = StreamController<User>.broadcast();
  //
  // Stream<User> get userResponse => _userResponse.stream;
  //
  // void Function(User) get addUserResponse => _userResponse.sink.add;

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
    var res = await _api.loginWithPhoneNumber(data: {
      'phone_number': phoneNumber,
      'password': password,
    });

    ///
    /// response = {"":user,"token":}
    ///
    if (res != null) {
      return true;
    }

    return false;
  }

  Future<bool> loginWithSocials({
    required String name,
    required String phoneNumber,
    required String email,
    required TypeSocial providerId,
  }) async {
    var res = await _api.loginWithSocials(
      data: {
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'provider_id': providerId.index
      },
      typeSocial: providerId,
    );

    ///
    /// response = {"":user,"token":}
    ///
    if (res != null) {
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
        'password_confirmation': password
      },
    );

    ///
    /// response = {"":user,"token":}
    ///
    if (res != null) {
      return true;
    }

    return false;
  }
}
