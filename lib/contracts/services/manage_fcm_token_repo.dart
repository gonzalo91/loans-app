abstract class ManageFcmTokenRepo {
  Future<void> save(String token);

  Future<void> update(String newToken);
}
