import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const secureStorage = FlutterSecureStorage();

  static Future<String?> read(String key) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> write(String key, String? value) async {
    return await secureStorage.write(key: key, value: value);
  }

  static Future<void> delete(String key) async {
    return await secureStorage.delete(key: key);
  }
}
