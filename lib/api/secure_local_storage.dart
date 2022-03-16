import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  static final _instance = SecureLocalStorage._internal();

  factory SecureLocalStorage() {
    return _instance;
  }
  SecureLocalStorage._internal();

  Future<void> write(String key, dynamic value) {
    return storage.write(key: key, value: value);
  }

  Future<void> delete(String key) {
    return storage.delete(key: key);
  }

  Future<String?> read(String key) {
    return storage.read(key: key);
  }
}
