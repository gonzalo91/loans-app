import 'package:http/http.dart' as http;
import 'package:loans_flutter/api/secure_local_storage.dart';

class HttpClient {
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
    var uri = Uri.parse('$baseUrl$url').replace(queryParameters: body);

    return http.post(uri, body: body);
  }
}
