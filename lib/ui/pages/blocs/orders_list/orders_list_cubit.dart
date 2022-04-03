import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:loans_flutter/datasources/orders.dart';
import 'package:loans_flutter/models/order.dart';

part 'orders_list_state.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  final orderDataSource = OrderDatasource();

  OrdersListCubit() : super(OrdersListInitial()) {
    getOrders();
  }

  getOrders() async {
    try {
      var orders = await orderDataSource.getOrders();

      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError());
    }
  }
}
