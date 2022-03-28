import 'dart:io';
import 'dart:convert';

import 'package:loans_flutter/models/token.dart';
import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/errors/http_error.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';

class AuthDatasource {
  static final _httpClient = HttpClient();

  static Future<AuthToken> login(String email, String password) async {
    var response = await _httpClient.post('login', {
      'email': email,
      'password': password,
    });

    var body = jsonDecode(response.body);

    if (response.statusCode == 422) {
      throw ValidationError(body['errors']);
    }

    if (response.statusCode == 429) {
      throw TooManyAttemptsError();
    }

    return AuthToken.fromJson(body);
  }

  static Future<AuthUser> verifyToken() async {
    var response = await _httpClient.get('user');

    if (response.statusCode != 200) {
      throw HttpException('${response.statusCode}');
    }

    var body = jsonDecode(response.body);

    return AuthUser.fromJson(body);
  }
}
