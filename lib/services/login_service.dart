import 'package:loans_flutter/models/token.dart';
import 'package:loans_flutter/contracts/api/http_client_repo.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';

class LoginService implements LoginServiceRepo {
  final HttpClientRepo httpClient;
  final SecureLocalStorageRepo secureLocalStorage;

  LoginService(this.httpClient, this.secureLocalStorage);

  @override
  Future<AuthToken> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
