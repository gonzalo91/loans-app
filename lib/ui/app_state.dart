import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans_flutter/ui/bloc/root_bloc.dart';
import 'package:loans_flutter/ui/pages/loans_page.dart';
import 'package:loans_flutter/ui/pages/login_page.dart';

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

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
