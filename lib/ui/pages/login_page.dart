import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans_flutter/datasources/auth.dart';
import 'package:loans_flutter/ui/bloc/root_bloc.dart';
import 'package:loans_flutter/ui/pages/blocs/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: "test1@mail.com");
  final passwordController = TextEditingController(text: 'test1@mail.com');
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  IconData _iconVisible = Icons.visibility_off;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  final Color _backgroundColor = Color(0xFFE6EFFC);
  final Color _underlineColor = Color(0xFF0443A2);
  final Color _buttonColor = Color(0xFF0443A2);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is TooManyAttemptsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }

          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Bienvenido!'),
            ));

            context.read<RootBloc>().add(
                  RootCheckAuth(),
                );
          }
        },
        child: Scaffold(
            backgroundColor: _backgroundColor,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(32, 72, 32, 24),
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage(
                            'assets/images/prestamos.tk-logo-small-nobg.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginValidationErrorState) {
                        return inputLogin('Las credenciales son invalidas');
                      }

                      return inputLogin(null);
                    }),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }

                        return null;
                      },
                      controller: passwordController,
                      obscureText: _obscureText,
                      //style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _underlineColor),
                        ),
                        labelText: 'Password',
                        //labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                            icon: Icon(_iconVisible,
                                color: Colors.white, size: 20),
                            onPressed: () {
                              _toggleObscureText();
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        var loading = false;

                        if (state is LoginVerifing) {
                          loading = true;
                        }

                        return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) => _buttonColor,
                              ),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              )),
                            ),
                            onPressed: loading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                          LoginAttemptEvent(
                                              emailController.text,
                                              passwordController.text));
                                    }
                                  },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Iniciar Sesion',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (loading)
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  if (loading)
                                    const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                ],
                              ),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  TextFormField inputLogin(String? error) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },

      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        errorText: error,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _underlineColor),
        ),
        labelText: 'Email',
        //  labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
