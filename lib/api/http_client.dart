import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loans_flutter/api/secure_local_storage.dart';
import 'package:loans_flutter/contracts/api/http_client_repo.dart';

class HttpClient implements HttpClientRepo {
  final String baseUrl = 'http://localhost/api/';
  static final _instance = HttpClient._internal();

  factory HttpClient() {
    return _instance;
  }
  HttpClient._internal();

  Future<http.Response> get(url, [Map<String, String>? body]) async {
    SecureLocalStorage secureLocalStorage = SecureLocalStorage();
    String? token = await secureLocalStorage.read('token');

    var uri = Uri.parse('$baseUrl$url').replace(queryParameters: body);

    return http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<http.Response> post(
    url,
    Map<String, String> body,
  ) async {
    SecureLocalStorage secureLocalStorage = SecureLocalStorage();
    String? token = await secureLocalStorage.read('token');
    var uri = Uri.parse('$baseUrl$url');

    return http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
