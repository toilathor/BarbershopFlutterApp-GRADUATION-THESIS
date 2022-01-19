import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreSecure {
  FlutterSecureStorage? _storage;

  final _keyUser = 'user';
  final _keyToken = 'token';

  StoreSecure() {
    getInstance();
  }
  Future setUser(String? user) async {
    await _storage?.write(key: _keyUser, value: user ?? '');
  }

  Future<String?> getUser() async {
    return await _storage?.read(key: _keyUser);
  }

  Future setToken(String? token) async {
    await _storage?.write(key: _keyToken, value: token ?? '');
  }

  Future<String?> getToken() async {
    return await _storage?.read(key: _keyToken);
  }

  getInstance() async {
    if (_storage == null) {
      _storage = const FlutterSecureStorage();
    } else {
      return;
    }
  }
}
