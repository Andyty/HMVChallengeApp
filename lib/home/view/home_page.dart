
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmv_challenge_app/authentication/bloc/authentication_bloc.dart';
import 'package:hmv_challenge_app/scheduler/view/scheduler_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pageTitle = [
    Text("Página Inicial"),
    Text("Agendamento")
  ];
  final List<Widget> _screens = [
    HomePageScreen(),
    SchedulerPage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pageTitle[_currentPageIndex],
      ),
      body: _screens[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
            label: 'Agendamento'
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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

