part of 'loan_fund_cubit.dart';

@immutable
abstract class LoanFundState {}

class LoanFundInitial extends LoanFundState {}

class Funding extends LoanFundState {}

class Founded extends LoanFundState {}

class Error extends LoanFundState {}

class ValidationError extends LoanFundState {
  final Map<String, dynamic> validations;

  ValidationError(this.validations);

  String get firstError {
    var firstError = List<String>.from(validations[validations.keys.first]);

    return firstError.first;
  }
}
