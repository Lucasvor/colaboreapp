import 'package:colaboreapp/Screens/HomeOng/HomeOng.dart';
import 'package:colaboreapp/bloc/HomeOng/homeong_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOngForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;

  const HomeOngForm({Key key, this.userRepository, this.usuario})
      : super(key: key);

  @override
  _HomeOngFormState createState() => _HomeOngFormState();
}

class _HomeOngFormState extends State<HomeOngForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocListener<HomeongBloc, HomeongState>(
      listener: (context, state) {
        if (state.isLoadHome) {}
      },
      child: BlocBuilder<HomeongBloc, HomeongState>(
        builder: (context, state) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text('Bem vindo Ong: ${widget.usuario.displayName}'),
                ),
                Container(
                  width: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RoundedButton(
                      color: Colors.red,
                      text: 'Sair',
                      textColor: Colors.white,
                      press: () async {
                        try {
                          await widget.userRepository.singOut();
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSplash(),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {}
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
