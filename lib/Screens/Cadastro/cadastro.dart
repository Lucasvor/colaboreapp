import 'package:colaboreapp/Screens/Cadastro/cadastroForm.dart';
import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/repositories/OngRepository.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cadastroFormOng.dart';

class Cadastro extends StatelessWidget {
  final bool selecionaCadastro;
  final UserRepository userRepository;
  final OngRepository ongRepository;

  const Cadastro(
      {Key key,
      this.userRepository,
      this.ongRepository,
      this.selecionaCadastro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CadastroBloc>(
        create: (context) => CadastroBloc(userRepository),
        child: selecionaCadastro
            ? CadastroForm(
                userRepository: userRepository,
              )
            : CadastroFormOng(
                ongRepository: ongRepository,
              ),
      ),
    );
  }
}
