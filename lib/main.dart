import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:loans_flutter/ui/app_state.dart';
import 'package:loans_flutter/ui/pages/loans_page.dart';
import 'package:loans_flutter/ui/pages/login_page.dart';
import 'package:loans_flutter/ui/pages/orders_page.dart';
import 'package:loans_flutter/injection_container.dart' as ic;
import 'package:loans_flutter/ui/pages/user_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await ic.init();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppState(),
      // initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/loans-page': (context) => const LoansPage(),
        '/user-page': (context) => const UserPage(),
        '/orders-page': (context) => const OrdersPage(),
      },
    );
  }
}
