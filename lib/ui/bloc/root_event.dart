part of 'root_bloc.dart';

@immutable
abstract class RootEvent {}

class RootInitializeApp extends RootEvent {}

class RootCheckAuth extends RootEvent {}

class RootLogOutEvent extends RootEvent {}
