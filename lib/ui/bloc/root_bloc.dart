import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:loans_flutter/injection_container.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/contracts/services/verify_auth_service_repo.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final LoginServiceRepo loginServiceRepo = sl<LoginServiceRepo>();
  final VerifyAuthServiceRepo _verifyAuthServiceRepo =
      sl<VerifyAuthServiceRepo>();

  bool hasRemoveSplash = false;

  RootBloc() : super(RootInitial()) {
    on<RootInitializeApp>((event, emit) async {
      await _verifyAuth(emit);
    });

    on<RootCheckAuth>((event, emit) async {
      await _verifyAuth(emit);
    });
  }

  Future<void> _verifyAuth(emit) async {
    try {
      var verifiedModel = await _verifyAuthServiceRepo.verify();

      if (verifiedModel.status == Statuses.authenticated) {
        return emit(RootAuthenticated());
      }

      return emit(RootUnauthenticated());
    } catch (e) {
      return emit(RootUnauthenticated());
    } finally {
      if (!hasRemoveSplash) {
        FlutterNativeSplash.remove();
        hasRemoveSplash = true;
      }
    }
  }
}
