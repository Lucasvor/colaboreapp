import 'package:colaboreapp/Screens/Home/home.dart';
import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroParent extends StatelessWidget {
  final UserRepository userRepository;

  const CadastroParent({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CadastroBloc(userRepository),
      child: Cadastro(
        userRepository: userRepository,
      ),
    );
  }
}

class Cadastro extends StatelessWidget {
  final UserRepository userRepository;

  const Cadastro({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocListener<CadastroBloc, CadastroState>(
            listener: (context, state) {
              if (state is CadastroSuccessfulState) {
                navigateToHomePage(context, state.user);
              }
            },
            child: BlocBuilder<CadastroBloc, CadastroState>(
              builder: (context, state) {
                if (state is CadastroInitial) {
                } else if (state is CadastroLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CadastroFailure) {
                  return SnackBar(content: Text(state.message));
                } else if (state is CadastroSuccessfulState) {}
              },
            ),
          ),
          Text('Cadastro'),
        ],
      ),
    );
  }

  void navigateToHomePage(BuildContext context, FirebaseUser user) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeParent(user: user, userRepository: userRepository);
    }));
  }
}
