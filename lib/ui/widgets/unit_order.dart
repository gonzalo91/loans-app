import 'package:flutter/material.dart';

import 'package:loans_flutter/models/order.dart';

class UnitOrder extends StatelessWidget {
  final Order order;
  const UnitOrder(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: false,
      textColor: Colors.grey,
      selectedColor: Colors.green,
      leading: CircleAvatar(
        child: Text(
          order.loan.rate,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      title: Container(
        child: Row(
          children: [
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  'Id Orden: ${order.id}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  order.statusText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(),
                  ),
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Text(
                  order.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text('ID Prestamo: # ${order.loan.id}'),
          Container(
            width: 52,
          ),
          const Text(
            'Total prestamo: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${order.loan.totalAmount}'),
        ],
      ),
      trailing: Text(
        order.amountToShow,
        style: const TextStyle(color: Colors.green, fontSize: 18),
      ),
    );
  }

  Color getStatusColor() {
    var color = Colors.grey;

    switch (order.status) {
      case 0:
        color = Colors.red;
        break;
      case 1:
        color = Colors.blue;
        break;
      case 2:
        color = Colors.orange;
        break;
      case 3:
        color = Colors.green;
        break;
    }

    return color;
  }
}
