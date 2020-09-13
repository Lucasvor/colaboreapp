import 'package:colaboreapp/Screens/Cadastro/cadastroForm.dart';
import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cadastro extends StatelessWidget {
  final UserRepository userRepository;
  final UserRepository ongRepository;

  const Cadastro({Key key, this.userRepository, this.ongRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CadastroBloc>(
        create: (context) => CadastroBloc(userRepository),
        child: BlocProvider(
          create: (context) => CadastroBloc(userRepository),
          child: CadastroForm(
            userRepository: userRepository,
          ),
        ),
      ),
    );
  }
}
