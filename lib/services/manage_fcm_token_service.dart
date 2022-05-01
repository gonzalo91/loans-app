import 'package:loans_flutter/datasources/fcm_token.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';
import 'package:loans_flutter/contracts/services/manage_fcm_token_repo.dart';

class ManageFcmTokenService implements ManageFcmTokenRepo {
  final SecureLocalStorageRepo secureLocalStorage;

  ManageFcmTokenService(this.secureLocalStorage);

  @override
  Future<void> save(String token) async {
    try {
      await FcmTokenDatasource.save(token);

      await secureLocalStorage.write('fcm_token', token);
    } catch (e) {
      print('Silently fails');
    }
  }

  @override
  Future<void> update(String newToken) async {
    try {
      var oldToken = await secureLocalStorage.read('fcm_token');

      if (oldToken != null && oldToken.isNotEmpty) {
        await FcmTokenDatasource.delete(oldToken);
      }

      await FcmTokenDatasource.save(newToken);

      await secureLocalStorage.write('fcm_token', newToken);
    } catch (e) {
      print('Silently fails');
    }
  }
}
