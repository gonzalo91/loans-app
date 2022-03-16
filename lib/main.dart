import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loans_flutter/helpers/verify_auth.dart';

import 'package:loans_flutter/pages/loans_page.dart';
import 'package:loans_flutter/pages/login_page.dart';
import 'package:loans_flutter/pages/orders_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  var verifyAuth = await VerifyAuth().verify();

  FlutterNativeSplash.remove();
  runApp(
    MyApp(
      authModel: verifyAuth,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthModel authModel;

  const MyApp({Key? key, required this.authModel}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var initialRoute =
        authModel.status == Statuses.authenticated ? '/loans-page' : '/';

    print(initialRoute);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginPage(),
        '/loans-page': (context) => const LoansPage(),
        '/orders-page': (context) => const OrdersPage(),
      },
    );
  }
}
