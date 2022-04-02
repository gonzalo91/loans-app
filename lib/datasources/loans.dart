import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/errors/http_error.dart';
import 'package:loans_flutter/models/loan.dart';

class LoansDatasource {
  static final _httpClient = HttpClient();

  Future<List<Loan>> getLoansToFund() async {
    var response = await _httpClient.get('loans');

    var body = jsonDecode(response.body);
    var data = (body['data']) as List<dynamic>;

    List<Loan> loans = [];

    data.forEach((l) {
      loans.add(Loan(l['id'], l['interest_rate'], l['total_amount'],
          l['amount_to_fund'], l['orders_count']));
    });

    return loans;
  }

  Future<Either<ValidationError, bool>> fundLoan(
      Loan loan, double amount) async {
    var response = await _httpClient.post('orders', {
      'amount_to_fund': amount,
      'loan_id': loan.id,
    });

    var body = jsonDecode(response.body);

    if (response.statusCode == 422) {
      return Left(ValidationError(body['errors']));
    }

    return const Right(true);
  }
}
