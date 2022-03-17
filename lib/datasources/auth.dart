import 'dart:convert';
import 'dart:io';

import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/models/token.dart';

class AuthDatasource {
  static final _httpClient = HttpClient();

  static Future<AuthToken> login(String email, String password) async {
    try {
      var response = await _httpClient.post('login', {
        'email': email,
        'password': password,
      });

      print(response.body);

      return AuthToken('asd');
    } on HttpException catch (e) {
      print(e.message);
      return AuthToken('token');
    }
  }

  static Future<bool> verifyToken() async {
    try {
      var response = await _httpClient.get('user');

      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      return true;
    } on Exception {
      return false;
    }
  }
}
