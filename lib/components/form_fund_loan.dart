import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans_flutter/models/loan.dart';
import 'package:loans_flutter/ui/pages/blocs/loan_fund/loan_fund_cubit.dart';

class FormFundLoan extends StatefulWidget {
  final Loan loan;

  FormFundLoan(
    this.loan, {
    Key? key,
  }) : super(key: key);

  @override
  State<FormFundLoan> createState() => _FormFundLoanState();
}

class _FormFundLoanState extends State<FormFundLoan> {
  final fundInputController = TextEditingController();

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // must use StateSetter to update data between main screen and popup.
    // if use default setState, the data will not update
    return BlocProvider(
      create: (context) => LoanFundCubit(),
      child: BlocListener<LoanFundCubit, LoanFundState>(
        listener: (context, state) {
          if (state is Founded) {
            final snackBar = SnackBar(
                elevation: 5,
                backgroundColor: Colors.green[200],
                behavior: SnackBarBehavior.floating,
                content: const Text('Orden Creada'));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Prestamo #${widget.loan.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: BlocBuilder<LoanFundCubit, LoanFundState>(
                          builder: (context, state) {
                            return TextFormField(
                              controller: fundInputController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Introduce el monto a fondear',
                                errorText: state is ValidationError
                                    ? state.firstError
                                    : null,
                              ),

                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Es necesario escribir un monto';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setValue("200.00");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '\$200.00',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.green),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setValue("500.00");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '\$500.00',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.green),
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setValue("1000.00");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '\$1000.00',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                child: BlocBuilder<LoanFundCubit, LoanFundState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 45)),
                      onPressed: state is Funding
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                var bloc =
                                    BlocProvider.of<LoanFundCubit>(context);

                                bloc.fundLoan(widget.loan,
                                    double.parse(fundInputController.text));
                              }
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Fondear!'),
                          if (state is Funding)
                            const SizedBox(width: 20), // give it width
                          if (state is Funding)
                            const SizedBox(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              height: 20.0,
                              width: 20.0,
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: BlocBuilder<LoanFundCubit, LoanFundState>(
                  builder: (context, state) {
                    if (state is Error) {
                      return Center(
                          child: Text(
                        'Hubo algún error, intentalo de nuevo mas tarde',
                        style: TextStyle(color: Colors.red[300]),
                      ));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setValue(String value) {
    fundInputController.text = value;
  }
}
