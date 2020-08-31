import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final User usuario;

  const Home({Key key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bem vindo a home, ${usuario.displayName}',
                textAlign: TextAlign.center,
              ),
              RoundedButton(
                text: 'Voltar',
                press: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
