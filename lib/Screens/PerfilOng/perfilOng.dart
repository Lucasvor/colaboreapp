import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOngForm.dart';
import 'package:flutter/material.dart';

class PerfilOng extends StatelessWidget {
  final Ong ong;
  final String ongNome;
  const PerfilOng({Key key, this.ong, this.ongNome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PerfilOngForm(
        ong: ong,
        ongNome: ongNome,
      ),
    );
  }
}
