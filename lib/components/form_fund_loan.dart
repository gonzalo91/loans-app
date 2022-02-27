import 'package:flutter/material.dart';
import 'package:loans_flutter/models/loan.dart';

class FormFundLoan extends StatelessWidget {
  final fundInputController = TextEditingController();
  final Loan loan;

  FormFundLoan(
    this.loan, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // must use StateSetter to update data between main screen and popup.
    // if use default setState, the data will not update
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return SingleChildScrollView(
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
                        'Prestamo #${loan.id}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        controller: fundInputController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Introduce el monto a fondear',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Es necesario escribir un monto';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (false)
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Hola',
                          style: TextStyle(color: Colors.red, fontSize: 12),
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
                              child: const Text(
                                '\$200.00',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setValue("500.00");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                '\$500.00',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setValue("1000.00");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                '\$1000.00',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
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
              margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(20, 45)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('hola');
                  }
                },
                child: const Text('Fondear!'),
              ),
            ),
          ],
        ),
      );
    });
  }

  setValue(String value) {
    fundInputController.text = value;
  }
}
