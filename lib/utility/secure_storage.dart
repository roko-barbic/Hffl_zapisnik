import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _jwtKey = 'jwt_token';
  static const _refreshKey = 'refresh_token';

  static Future<void> saveTokens(String token, String refreshToken) async {
    await _storage.write(key: _jwtKey, value: token);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  static Future<String?> getToken() async => await _storage.read(key: _jwtKey);
  static Future<String?> getRefreshToken() async => await _storage.read(key: _refreshKey);
  static Future<bool> isThereToken() async => await _storage.containsKey(key: 'jwt_token');

  static Future<void> deleteTokens() async {
    await _storage.delete(key: _jwtKey);
    await _storage.delete(key: _refreshKey);
  }
}