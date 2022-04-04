import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:loans_flutter/injection_container.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final SecureLocalStorageRepo secureLocalStorageRepo =
      sl<SecureLocalStorageRepo>();

  UserInfoCubit() : super(UserInfoInitial('', '', '', '')) {
    getUserData();
  }

  getUserData() async {
    String? userString = await secureLocalStorageRepo.read('user');

    if (!["", null, false, 0].contains(userString)) {
      var authUser = AuthUser.fromJson(jsonDecode((userString as String)));

      emit(UserInfoInitial(authUser.name, authUser.balance.toString(),
          authUser.email, authUser.imageProfile));
    }
  }

  logOut() async {
    await secureLocalStorageRepo.delete('user');
    await secureLocalStorageRepo.delete('token');
  }
}
