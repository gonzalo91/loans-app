part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginVerifing extends LoginState {}

class LoginValidationErrorState extends LoginState {
  final Map<String, dynamic> validations;

  LoginValidationErrorState(this.validations);
}

class TooManyAttemptsErrorState extends LoginState {
  final String message;

  TooManyAttemptsErrorState(this.message);
}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {}
