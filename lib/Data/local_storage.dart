import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const storage = FlutterSecureStorage();

  Future write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future read(String key) async {
    await storage.read(key: key);
  }

  Future delete(String key) async {
    await storage.delete(key: key);
  }

  Future clear() async {
    await storage.deleteAll();
  }
}
