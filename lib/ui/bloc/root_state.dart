part of 'root_bloc.dart';

@immutable
abstract class RootState {}

class RootInitial extends RootState {
  final bool authenticated = false;
  final bool serverVerificationAuth = false;
}

class RootAuthenticated extends RootState {
  final bool authenticated = true;
  final bool serverVerificationAuth = true;
}

class RootUnauthenticated extends RootState {
  final bool authenticated = false;
  final bool serverVerificationAuth = true;
}
