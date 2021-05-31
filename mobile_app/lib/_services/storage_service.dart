
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  static const TOKEN_KEY = 'token';
  static const REFRESH_TOKEN_KEY = 'refresh-token';

  static const USER_ID = 'user';

  static FlutterSecureStorage secureStorage = FlutterSecureStorage();


  static Future<String?> get(String key) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> set(String key, String value) async{
    await secureStorage.write(key: key, value: value);
  }

}