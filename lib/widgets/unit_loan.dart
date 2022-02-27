import 'package:flutter/material.dart';
import 'package:loans_flutter/components/form_fund_loan.dart';
import 'package:loans_flutter/models/loan.dart';

class UnitLoan extends StatelessWidget {
  final Loan loan;
  const UnitLoan(this.loan, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: false,
      textColor: Colors.grey,
      selectedColor: Colors.green,
      leading: CircleAvatar(
        child: Text(
          loan.rate,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      title: Container(
        child: Row(
          children: [
            const Text(
              'Por fondear: ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Text('${loan.amountToFund}'),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text('ID: # ${loan.id}'),
          Container(
            width: 52,
          ),
          const Text(
            'Total prestamo: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${loan.totalAmount}'),
          Container(
            width: 52,
          ),
        ],
      ),
      trailing: IconButton(
        iconSize: 25,
        icon: const Icon(
          Icons.attach_money,
          color: Colors.green,
        ),
        tooltip: 'Fondear',
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: FormFundLoan(loan),
            ),
          );
        },
      ),
    );
  }
}
