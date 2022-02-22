
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/login/login.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      //appBar: AppBar(title: const Text('Login'),),
      body: Container(
        color: Color.fromRGBO(7, 81, 143, 1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context)
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
