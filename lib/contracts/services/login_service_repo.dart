import 'package:loans_flutter/models/token.dart';

abstract class LoginServiceRepo {
  //final HttpClientRepo httpClient;

  Future<AuthToken> login(String email, String password);
}
