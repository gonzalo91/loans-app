class Loan {
  final int _id;
  int get id => _id;

  final String _rate;
  String get rate => _rate;

  final String _totalAmount;
  String get totalAmount => _totalAmount;

  final String _amountToFund;
  String get amountToFund => _amountToFund;

  Loan(this._id, this._rate, this._totalAmount, this._amountToFund);
}
