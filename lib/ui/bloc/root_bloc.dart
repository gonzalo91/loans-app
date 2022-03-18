import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/helpers/verify_auth_helper.dart';
import 'package:loans_flutter/injection_container.dart';
import 'package:meta/meta.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final LoginServiceRepo loginServiceRepo = sl<LoginServiceRepo>();
  final VerifyAuthHelper authHelper = sl<VerifyAuthHelper>();

  bool hasRemoveSplash = false;

  RootBloc() : super(RootInitial()) {
    on<RootInitializeApp>((event, emit) async {
      await _verifyAuth(emit);
    });
  }

  Future<void> _verifyAuth(emit) async {
    var verifiedModel = await authHelper.verify();

    if (!hasRemoveSplash) {
      FlutterNativeSplash.remove();
      hasRemoveSplash = true;
    }

    if (verifiedModel.status == Statuses.authenticated) {
      return emit(RootAuthenticated());
    }

    return emit(RootUnauthenticated());
  }
}
