import 'dart:convert';

import 'package:loans_flutter/datasources/auth.dart';
import 'package:loans_flutter/contracts/api/http_client_repo.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';

class VerifyAuthService implements VerifyAuthServiceRepo {
  final HttpClientRepo httpClient;
  final SecureLocalStorageRepo sLocalStorage;

  VerifyAuthService(this.httpClient, this.sLocalStorage);

  Future<bool> _verifyValidToken() async {
    try {
      var authUser = await AuthDatasource.verifyToken();

      sLocalStorage.write('user', jsonEncode(authUser.toJson()));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> _verifyTokenLocalStorage() async {
    return await sLocalStorage.read('token');
  }

  @override
  Future<AuthModel> verify() async {
    String? token = await _verifyTokenLocalStorage();

    if (token == null) {
      return AuthModel(Statuses.noAuth, 'Inicia Sesion');
    }

    if (!await _verifyValidToken()) {
      return AuthModel(Statuses.authExpired, 'Su sesion ha expirado');
    }

    return AuthModel(Statuses.authenticated, 'Ok');
  }
}
