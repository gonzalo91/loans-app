import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';

class SecureLocalStorage implements SecureLocalStorageRepo {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  static final _instance = SecureLocalStorage._internal();

  factory SecureLocalStorage() {
    return _instance;
  }
  SecureLocalStorage._internal();

  @override
  Future<void> write(String key, dynamic value) {
    return storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) {
    return storage.delete(key: key);
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }
}
