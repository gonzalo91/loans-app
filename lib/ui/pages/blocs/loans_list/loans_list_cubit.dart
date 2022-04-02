import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:loans_flutter/models/loan.dart';
import 'package:loans_flutter/datasources/loans.dart';

part 'loans_list_state.dart';

class LoansListCubit extends Cubit<LoansListState> {
  final loansDataSource = LoansDatasource();

  LoansListCubit() : super(LoansListInitial()) {
    emit(LoadingState());
    getLoans();
  }

  getLoans() async {
    try {
      var loans = await loansDataSource.getLoansToFund();

      emit(LoadedState(loans));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
