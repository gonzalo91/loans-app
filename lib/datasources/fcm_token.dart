import 'package:loans_flutter/api/http_client.dart';

class FcmTokenDatasource {
  static final _httpClient = HttpClient();

  static Future<bool> save(
    String token,
  ) async {
    await _httpClient.post('user/save-token', {
      'token': token,
    });

    return true;
  }

  static Future<bool> delete(
    String token,
  ) async {
    await _httpClient.delete('user/save-token', {
      'token': token,
    });

    return true;
  }
}
