part of 'loans_list_cubit.dart';

@immutable
abstract class LoansListState {
  List<Object> get props => [];
}

class LoansListInitial extends LoansListState {}

class LoadingState extends LoansListState {}

class ErrorState extends LoansListState {}

class LoadedState extends LoansListState {
  final List<Loan> loans;

  LoadedState(this.loans);

  List<Object> get props => [loans];
}
