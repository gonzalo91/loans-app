import 'package:flutter/material.dart';
import 'package:loans_flutter/models/loan.dart';
import 'package:loans_flutter/models/order.dart';
import 'package:loans_flutter/widgets/unit_order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sus ordenes')),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              child: UnitOrder(Order(10, 3, 'Aprobada', '2022-10-10',
                  '\$ 200.00', Loan(2, '17.0%', '20000.00', '18000.00'))),
            ),
          ],
        ),
      ),
    );
  }
}
