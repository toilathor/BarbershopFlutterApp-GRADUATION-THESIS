import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreSecure {
  static const _storage = FlutterSecureStorage();

  static const _keyUser = 'user';
  static const _keyToken = 'token';

  static Future setUser(String? user) async {
    await _storage.write(key: _keyUser, value: user ?? '');
  }

  static Future<String?> getUser() async => await _storage.read(key: _keyUser);

  static Future setToken(String? token) async {
    await _storage.write(key: _keyToken, value: token ?? '');
  }

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);
}
