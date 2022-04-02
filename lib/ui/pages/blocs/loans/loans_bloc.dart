import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:loans_flutter/contracts/api/secure_local_storage_repo.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';
import 'package:loans_flutter/injection_container.dart';
import 'package:meta/meta.dart';

part 'loans_event.dart';
part 'loans_state.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  final SecureLocalStorageRepo secureLocalStorageRepo =
      sl<SecureLocalStorageRepo>();

  LoansBloc() : super(LoansInitial('', 0.00)) {
    getUserData();

    on<LoansEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  getUserData() async {
    String? userString = await secureLocalStorageRepo.read('user');
    if (!["", null, false, 0].contains(userString)) {
      var authUser = AuthUser.fromJson(jsonDecode((userString as String)));

      emit(LoansInitial(authUser.name, authUser.balance));
    }
  }
}
