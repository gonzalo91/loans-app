import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loans_flutter/ui/app_state.dart';
import 'package:loans_flutter/ui/pages/blocs/user_info/user_info_cubit.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Color _gradientTop = Color(0xFF039be6);
  Color _gradientBottom = Color(0xFF0299e2);
  Color _color1 = Color(0xFF0181cc);
  Color _color2 = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height / 3;
    if (kIsWeb) {
      topHeight = MediaQuery.of(context).size.height / 2.5;
    }
    return BlocProvider(
      create: (context) => UserInfoCubit(),
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Platform.isIOS
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                  height: topHeight,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [_gradientTop, _gradientBottom],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 8)),
                  child: Image.asset(
                      'assets/images/prestamos.tk-logo-small-nobg.png',
                      height: 80,
                      color: Colors.white),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                      top: (topHeight) -
                          MediaQuery.of(context).size.width / 5.5),
                  child: BlocBuilder<UserInfoCubit, UserInfoState>(
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          if (state.imageProfile.isNotEmpty)
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: MediaQuery.of(context).size.width / 5.5,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius:
                                    (MediaQuery.of(context).size.width / 5.5) -
                                        4,
                                child: ClipOval(
                                    child: Image.network(state.imageProfile)),
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 64),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.person,
                                        color: _color1, size: 20),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                        child: Text(state.name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _color2,
                                                fontWeight: FontWeight.w600)))
                                  ],
                                ),
                                SizedBox(height: 24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.email, color: _color1, size: 20),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                        child: Text(state.email,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _color2,
                                                fontWeight: FontWeight.w600)))
                                  ],
                                ),
                                const SizedBox(height: 40),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cerrar Sesion',
                                          style:
                                              TextStyle(color: Colors.red[300]),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.person_off,
                                          color: Colors.red[300],
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Cerrar Sesion"),
      onPressed: () async {
        var bloc = BlocProvider.of<UserInfoCubit>(context);

        await bloc.logOut();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const AppState()),
            (route) => false);
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Estás a punto de cerrar sesion"),
      content: const Text("¿Quieres continuar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
