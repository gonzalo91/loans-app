import 'package:bloc/bloc.dart';
import 'package:loans_flutter/datasources/loans.dart';
import 'package:loans_flutter/models/loan.dart';
import 'package:meta/meta.dart';

part 'loan_fund_state.dart';

class LoanFundCubit extends Cubit<LoanFundState> {
  final _loansDataSource = LoansDatasource();
  LoanFundCubit() : super(LoanFundInitial());

  fundLoan(Loan loan, double amount) async {
    try {
      emit(Funding());

      var response = await _loansDataSource.fundLoan(loan, amount);

      if (response.isLeft) {
        return emit(ValidationError(response.left.failedValidations));
      }

      emit(Founded());
    } catch (e) {
      emit(Error());
    }
  }
}
