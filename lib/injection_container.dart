import 'package:get_it/get_it.dart';
import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/api/secure_local_storage.dart';

import 'package:loans_flutter/services/login_service.dart';
import 'package:loans_flutter/services/verify_auth_service.dart';

import 'package:loans_flutter/contracts/api/http_client_repo.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Api
  sl.registerLazySingleton<HttpClientRepo>(() => HttpClient());
  sl.registerLazySingleton<SecureLocalStorageRepo>(() => SecureLocalStorage());

  // Services
  sl.registerFactory<LoginServiceRepo>(() => LoginService(sl(), sl()));
  sl.registerFactory<VerifyAuthServiceRepo>(
      () => VerifyAuthService(sl(), sl()));

  // Helpers
}
