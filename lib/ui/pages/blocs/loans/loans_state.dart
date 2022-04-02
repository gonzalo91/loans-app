part of 'loans_bloc.dart';

@immutable
abstract class LoansState {}

class LoansInitial extends LoansState {
  final String name;
  final double balance;

  LoansInitial(this.name, this.balance);
}
