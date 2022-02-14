
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.id
                );
                return Text('UserID: $userId');
              }
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
              },
            )
          ],
        ),
      ),
    );
  }
}
