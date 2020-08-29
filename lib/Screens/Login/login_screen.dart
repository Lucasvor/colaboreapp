import 'package:colaboreapp/Screens/Cadastro/cadastro.dart';
import 'package:colaboreapp/Screens/Home/home.dart';
import 'package:colaboreapp/Screens/Login/components/background.dart';
import 'package:colaboreapp/Screens/Login/components/body.dart';
import 'package:colaboreapp/bloc/Login/login_bloc.dart';
import 'package:colaboreapp/components/input_field.dart';
import 'package:colaboreapp/components/password_field.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../main.dart';

class LoginScreenParent extends StatelessWidget {
  final UserRepository userRepository;

  const LoginScreenParent({Key key, @required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(this.userRepository),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController cpfCntrlr = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();
  LoginBloc loginBloc;
  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    loginBloc = BlocProvider.of(context);
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSucessState) {
                    navigateToHomeScreen(context, state.user);
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInitial) {
                      return Container(
                        child: Text('Sucesso'),
                      );
                    } else if (state is LoginLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoginFailureState) {
                      return SnackBar(content: Text(state.message));
                    } else if (state is LoginSucessState) {
                      cpfCntrlr.text = '';
                      passCntrlr.text = '';
                      return Container(
                        child: Text('Sucesso'),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.05,
              child: SvgPicture.asset(
                "assets/images/earth.svg",
                width: size.width * 0.5,
                color: kBackgroundColor,
              ),
            ),
            InputField(
              hintText: "CPF",
              textEditingController: cpfCntrlr,
              onChanged: (value) {},
            ),
            PasswordField(
              textEditingController: passCntrlr,
              onChanged: (value) {},
            ),
            Text(
              "Esqueci minha senha",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: HexColor("91C7A6")),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            RoundedButton(
              text: "CONTINUAR",
              press: () {
                loginBloc.add(
                    LoginButtonPressedEvent(cpfCntrlr.text, passCntrlr.text));
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: OutlineButton(
                borderSide: BorderSide(color: kPrimaryColorGreen),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                onPressed: () {
                  navigateToCadastroScreen(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "CADASTRA-SE",
                  style: TextStyle(color: HexColor("91C7A6")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomeParent(user: user, userRepository: userRepository);
    }));
  }

  void navigateToCadastroScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CadastroParent(userRepository: userRepository);
    }));
  }
}
