import 'package:colaboreapp/Screens/Home/homeForm.dart';
import 'package:colaboreapp/bloc/HomeOng/homeong_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOng extends StatelessWidget {
  final User usuario;
  final UserRepository userRepository;
  const HomeOng({Key key, this.usuario, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeongBloc(userRepository: userRepository),
        child: HomeForm(
          userRepository: userRepository,
          usuario: usuario,
        ),
      ),
    );
  }
}
