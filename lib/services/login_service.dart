import 'package:either_dart/either.dart';

import 'package:loans_flutter/models/token.dart';
import 'package:loans_flutter/datasources/auth.dart';
import 'package:loans_flutter/errors/http_error.dart';
import 'package:loans_flutter/contracts/api/http_client_repo.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';

class LoginService implements LoginServiceRepo {
  final HttpClientRepo httpClient;
  final SecureLocalStorageRepo secureLocalStorage;

  LoginService(this.httpClient, this.secureLocalStorage);

  @override
  Future<Either<HttpError, AuthToken>> login(
      String email, String password) async {
    try {
      var authtoken = await AuthDatasource.login(email, password);

      await secureLocalStorage.write('token', authtoken.token);

      return Right(authtoken);
    } on HttpError catch (e) {
      return Left(e);
    }
  }
}
