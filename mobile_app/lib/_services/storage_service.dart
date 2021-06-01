import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const TOKEN_KEY = 'token';
  static const REFRESH_TOKEN_KEY = 'refresh-token';

  static const USER_ID = 'user';

  static FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> setSession(session) async {
    await secureStorage.write(key: USER_ID, value: session["Id"]);
    await secureStorage.write(key: TOKEN_KEY, value: session["AccessToken"]);
    await secureStorage.write(
        key: REFRESH_TOKEN_KEY, value: session["RefreshToken"]);
  }

  static Future<String?> getAccessToken() async {
    return await secureStorage.read(key: TOKEN_KEY);
  }

  static Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: REFRESH_TOKEN_KEY);
  }

  static Future<String?> getId() async {
    return await secureStorage.read(key: USER_ID);
  }

  static Future<void> clearSession() async {
    await secureStorage.deleteAll();
  }
}
