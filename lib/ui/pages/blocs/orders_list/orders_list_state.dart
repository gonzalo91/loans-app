part of 'orders_list_cubit.dart';

@immutable
abstract class OrdersListState {}

class OrdersListInitial extends OrdersListState {}

class OrdersLoaded extends OrdersListState {
  final List<Order> orders;

  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersListState {}
