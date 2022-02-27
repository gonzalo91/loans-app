import 'package:loans_flutter/models/loan.dart';

class Order {
  final int _id;
  int get id => _id;

  final int _status;
  int get status => _status;

  final String _statusText;
  String get statusText => _statusText;

  final String _date;
  String get date => _date;

  final String _amountToShow;
  String get amountToShow => _amountToShow;

  final Loan _loan;
  Loan get loan => _loan;

  Order(this._id, this._status, this._statusText, this._date,
      this._amountToShow, this._loan);
}
