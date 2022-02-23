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
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Builder(builder: (context) {
              final userId = context
                  .select((AuthenticationBloc bloc) => bloc.state.user.id);
              return Text('UserID: $userId');
            }),
            Row(
              children: [
                Container(
                  height: 300,
                  child:  ElevatedButton(child: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),),
                )
              ],
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
