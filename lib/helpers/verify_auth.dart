import 'dart:io';

import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/api/secure_local_storage.dart';
import 'package:loans_flutter/datasources/auth.dart';

class VerifyAuth {
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

  Future<bool> _verifyValidToken() async {
    return await AuthDatasource.verifyToken();
  }

  Future<String?> _verifyTokenLocalStorage() async {
    SecureLocalStorage secureLocalStorage = SecureLocalStorage();

    return await secureLocalStorage.read('token');
  }
}

class AuthModel {
  final Statuses status;
  final String message;

  AuthModel(this.status, this.message);
}

enum Statuses {
  noAuth,
  authExpired,
  authenticated,
}
