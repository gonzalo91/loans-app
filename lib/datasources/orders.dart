import 'dart:convert';

import 'package:loans_flutter/api/http_client.dart';
import 'package:loans_flutter/models/loan.dart';
import 'package:loans_flutter/models/order.dart';

class OrderDatasource {
  static final _httpClient = HttpClient();

  Future<List<Order>> getOrders() async {
    var response = await _httpClient.get('orders');

    var body = jsonDecode(response.body);
    var data = (body['data']) as List<dynamic>;

    List<Order> orders = [];

    data.forEach((o) {
      var l = o['loan'];

      Loan loan = Loan(l['id'], l['interest_rate'], l['total_amount'], '0', 1);

      orders.add(Order(o['id'], o['status'], o['status_text'],
          o['created_at_formatted'], o['amount_to_show'], loan));
    });

    return orders;
  }
}
