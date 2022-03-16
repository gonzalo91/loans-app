import 'dart:io';

import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/api/secure_local_storage.dart';

class VerifyAuth {
  Future<AuthModel> verify() async {
    print('Verify!');
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
    var httpClient = HttpClient();
    try {
      var response = await httpClient.get('user');
      print(response);
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      return true;
    } on Exception {
      return false;
    }
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
