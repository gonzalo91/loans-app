import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:loans_flutter/main.dart';
import 'package:loans_flutter/ui/bloc/root_bloc.dart';
import 'package:loans_flutter/ui/pages/loans_page.dart';
import 'package:loans_flutter/ui/pages/login_page.dart';

class AppState extends StatefulWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null &&
          message.notification?.android != null) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android = notification.android!;
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      if (message.notification != null &&
          message.notification?.android != null) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android = notification.android!;
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RootBloc>(
          create: (_) => RootBloc()..add(RootInitializeApp()),
        ),
      ],
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          if (state is RootAuthenticated) {
            return const LoansPage();
          }

          return const LoginPage();
        },
      ),
    );
  }
}
