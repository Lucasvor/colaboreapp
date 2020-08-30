import 'package:colaboreapp/Screens/Cadastro/cadastro.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/background.dart';

class HomeParent extends StatelessWidget {
  final User user;
  final UserRepository userRepository;

  const HomeParent({Key key, this.user, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(userRepository),
      child: Home(user: user, userRepository: userRepository),
    );
  }
}

class Home extends StatelessWidget {
  User user;
  HomeBloc homeBloc;
  UserRepository userRepository;

  Home({@required this.user, @required this.userRepository});

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      body: Background(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home'),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is LogOutSucess) {
                  navigateToSignUpPage(context);
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return Container();
                  } else if (state is LogOutSucess) {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CadastroParent(userRepository: userRepository);
    }));
  }
}
