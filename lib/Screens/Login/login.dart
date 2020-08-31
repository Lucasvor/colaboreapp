import 'package:colaboreapp/Screens/Login/loginForm.dart';
import 'package:colaboreapp/bloc/Login/login_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;

  const Login({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(_userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
