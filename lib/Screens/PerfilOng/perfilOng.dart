import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOngForm.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilOng extends StatelessWidget {
  final Ong ong;
  final String ongNome;
  final HomeBloc homeBloc;
  final User usuario;
  final UserRepository userRepository;
  const PerfilOng(
      {Key key,
      this.ong,
      this.ongNome,
      this.homeBloc,
      this.usuario,
      this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PerfilOngForm(
        homeBloc: homeBloc,
        ong: ong,
        ongNome: ongNome,
        usuario: usuario,
        userRepository: userRepository,
      ),
    );
  }
}
