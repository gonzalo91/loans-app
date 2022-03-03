import 'package:flutter/material.dart';
import 'package:loans_flutter/components/form_fund_loan.dart';
import 'package:loans_flutter/models/loan.dart';
import 'package:loans_flutter/widgets/unit_loan.dart';
import 'package:loans_flutter/widgets/unit_order.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({Key? key}) : super(key: key);

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(child: Text('Prestamos aprobados')),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlue)),
              onPressed: () {
                Navigator.pushNamed(context, '/orders-page');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Tus prestamos',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              child: UnitLoan(Loan(2, '17.0%', '20000.00', '18000.00')),
            ),
          ],
        ),
      ),
    );
  }
}