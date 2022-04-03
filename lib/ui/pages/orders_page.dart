import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans_flutter/ui/widgets/unit_order.dart';
import 'package:loans_flutter/ui/pages/blocs/orders_list/orders_list_cubit.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sus ordenes')),
      body: BlocProvider(
        create: (context) => OrdersListCubit(),
        child: Container(
          child: Column(children: [
            BlocBuilder<OrdersListCubit, OrdersListState>(
              builder: (context, state) {
                if (state is OrdersError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Hubo un error al tratar de obtener tus ordenes',
                        style: TextStyle(color: Colors.red.shade300),
                      ),
                    ),
                  );
                }

                if (state is OrdersLoaded) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        var bloc = BlocProvider.of<OrdersListCubit>(context);

                        await bloc.getOrders();
                      },
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: state.orders
                            .map(
                              (order) => Card(
                                child: UnitOrder(order),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
