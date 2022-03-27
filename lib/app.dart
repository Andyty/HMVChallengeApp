import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hmv_challenge_app/authentication/bloc/authentication_bloc.dart';
import 'package:hmv_challenge_app/login/login.dart';
import 'package:hmv_challenge_app/scheduler/view/scheduler_page.dart';
import 'package:hmv_challenge_app/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR')
      ],
      locale: Locale('pt', 'BR'),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                  SchedulerPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(7, 81, 143, 1),
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: const Color.fromRGBO(7, 81, 143, 1),
              onPrimary: const Color.fromRGBO(255, 255, 255, 0.85),
              secondary: const Color.fromRGBO(230, 230, 230, 1),
              onSecondary: const Color.fromRGBO(7, 81, 143, 0.85),
              error: Colors.red.shade300,
              onError: const Color.fromRGBO(255, 255, 255, 0.85),
              background: const Color.fromRGBO(230, 230, 230, 1),
              onBackground: const Color.fromRGBO(7, 81, 143, 0.85),
              surface: const Color.fromRGBO(230, 230, 230, 1),
              onSurface: const Color.fromRGBO(7, 81, 143, 0.85)
          )
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
