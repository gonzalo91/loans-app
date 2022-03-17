abstract class SecureLocalStorageRepo {
  Future<void> write(String key, dynamic value);

  Future<void> delete(String key);

  Future<String?> read(String key);
}
