import 'package:either_dart/either.dart';
import 'package:loans_flutter/models/token.dart';
import 'package:loans_flutter/errors/http_error.dart';

abstract class LoginServiceRepo {
  //final HttpClientRepo httpClient;

  Future<Either<HttpError, AuthToken>> login(String email, String password);
}
