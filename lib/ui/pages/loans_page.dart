import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loans_flutter/ui/widgets/unit_loan.dart';
import 'package:loans_flutter/ui/pages/blocs/loans/loans_bloc.dart';
import 'package:loans_flutter/ui/pages/blocs/loans_list/loans_list_cubit.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({Key? key}) : super(key: key);

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoansBloc>(create: (_) => LoansBloc()),
        BlocProvider<LoansListCubit>(create: (_) => LoansListCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                  child: Text(
                'Fondeo',
                // style: TextStyle(fontSize: 12),
              )),
              OutlinedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue)),
                onPressed: () {
                  Navigator.pushNamed(context, '/orders-page');
                },
                child: Container(
                  child: const Text(
                    'Tus prestamos',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<LoansBloc, LoansState>(
          builder: (context, state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Bienvenido: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            if (state is LoansInitial) Text(state.name),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Saldo: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                if (state is LoansInitial)
                                  Text("\$ ${state.balance.toString()}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        var bloc = BlocProvider.of<LoansListCubit>(context);

                        await bloc.getLoans();
                      },
                      child: BlocBuilder<LoansListCubit, LoansListState>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return CircularProgressIndicator();
                          }

                          if (state is ErrorState) {
                            return Container(
                              height: 120,
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      children: const [
                                        Text('Hubo un error'),
                                        Icon(Icons.close),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          if (state is LoadedState) {
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: state.loans
                                  .map(
                                    (l) => Card(
                                      child: UnitLoan(
                                        l,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
