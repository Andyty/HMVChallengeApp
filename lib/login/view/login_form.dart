import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hmv_challenge_app/login/login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -0.6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/hmv_assist_logo.png',
                width: 1000,
                height: 280,
                color: Colors.white,
              ),
              const Padding(padding: EdgeInsets.all(12)),
              _UsernameInput(),
              const Padding(padding: EdgeInsets.all(12)),
              _PasswordInput(),
              const Padding(padding: EdgeInsets.all(12)),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              labelText: 'Usuário',
              errorText: state.username.invalid ? 'Usuário inválido' : null,
              labelStyle: TextStyle(
                color: state.username.invalid
                    ? Colors.red.shade300
                    : Colors.white70,
              ),
              errorStyle: TextStyle(
                color: Colors.red.shade300,
              ),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300)),
            ),
            cursorColor:
                state.username.invalid ? Colors.red.shade300 : Colors.white70,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          decoration: InputDecoration(
            labelText: 'Senha',
            errorText: state.password.invalid ? 'Senha inválida' : null,
            labelStyle: TextStyle(
              color:
                  state.password.invalid ? Colors.red.shade300 : Colors.white70,
            ),
            errorStyle: TextStyle(
              color: Colors.red.shade300,
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade300)),
          ),
          cursorColor:
              state.password.invalid ? Colors.red.shade300 : Colors.white70,
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: const Text('Login'),
                  onPressed: state.status.isValidated
                      ? () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Color.fromRGBO(150, 150, 150, 0.5);
                      }
                      return Colors.white.withOpacity(0.85);
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey.shade800.withOpacity(0.5);
                          }
                          return Colors.blueGrey.shade800;
                        }
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white.withOpacity(0.5);
                          }
                          return Colors.white.withOpacity(0.85);
                        }
                    ),
                  ),
                );
        });
  }
}
