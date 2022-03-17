import 'package:http/http.dart' as http;

abstract class HttpClientRepo {
  Future<http.Response> get(url, [Map<String, String>? body]);

  Future<http.Response> post(
    url,
    Map<String, String> body,
  );
}
