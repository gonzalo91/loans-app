import 'package:bloc/bloc.dart';
import 'package:loans_flutter/contracts/services/login_service_repo.dart';
import 'package:loans_flutter/errors/http_error.dart';
import 'package:loans_flutter/injection_container.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginServiceRepo loginService = sl<LoginServiceRepo>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginAttemptEvent>((event, emit) async {
      try {
        emit(LoginVerifing());

        var login = await loginService.login(event.email, event.password);

        if (login.isRight) {
          return emit(LoginSuccessState());
        }

        if (login.left is ValidationError) {
          var error = login.left as ValidationError;
          return emit(
            LoginValidationErrorState(
              error.failedValidations,
            ),
          );
        }

        if (login.left is TooManyAttemptsError) {
          return emit(
            TooManyAttemptsErrorState(login.left.message),
          );
        }
      } catch (e) {
        emit(LoginErrorState());
      }
    });
  }
}
