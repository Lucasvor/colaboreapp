import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOngForm.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:flutter/material.dart';

class PerfilOng extends StatelessWidget {
  final Ong ong;
  final String ongNome;
  final HomeBloc homeBloc;
  const PerfilOng({Key key, this.ong, this.ongNome, this.homeBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PerfilOngForm(
        homeBloc: homeBloc,
        ong: ong,
        ongNome: ongNome,
      ),
    );
  }
}
