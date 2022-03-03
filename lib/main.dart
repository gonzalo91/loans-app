import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loans_flutter/pages/loans_page.dart';
import 'package:loans_flutter/pages/login_page.dart';
import 'package:loans_flutter/pages/orders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/loans-page': (context) => const LoansPage(),
        '/orders-page': (context) => const OrdersPage(),
      },
    );
  }
}
