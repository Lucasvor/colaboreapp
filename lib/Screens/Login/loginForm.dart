import 'package:colaboreapp/Screens/Cadastro/cadastro.dart';
import 'package:colaboreapp/Screens/Cadastro/cadastroForm.dart';
import 'package:colaboreapp/bloc/Login/login_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../main.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  const LoginForm({Key key, UserRepository userRepository})
      : this.userRepository = userRepository,
        super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  final TextEditingController cpfController =
      new MaskedTextController(mask: '000.000.000-00');
  final TextEditingController senhaController = TextEditingController();

  bool mostraSenha = true;

  bool get isPopulated =>
      cpfController.text.isNotEmpty && senhaController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  LoginBloc _loginBloc;

  void _mostraSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    cpfController.addListener(() {
      _loginBloc.add(LoginCpfChange(cpf: cpfController.text));
    });
    senhaController.addListener(() {
      _loginBloc.add(LoginSenhaChange(senha: senhaController.text));
    });
  }

  @override
  void dispose() {
    cpfController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Falhou: ${state.message}'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: HexColor("91C7A6"),
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logando...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: HexColor("91C7A6"),
              ),
            );
        }
        if (state.isSucess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: size.height,
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/earth.svg",
                        width: size.width * 0.5,
                        color: kBackgroundColor,
                      ),
                      TextFormField(
                        controller: cpfController,
                        validator: (_) {
                          return !state.isCpfValid ? 'CPF inválido' : null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.person, color: kPrimaryColorGreen),
                          labelText: "CPF",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: kPrimaryColorGreen,
                            ),
                            onPressed: () {
                              cpfController.text = '';
                            },
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      TextFormField(
                        controller: senhaController,
                        validator: (_) {
                          return !state.isSenhaValid ? 'Senha inválida' : null;
                        },
                        obscureText: mostraSenha,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: kPrimaryColorGreen),
                          labelText: "Senha",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: kPrimaryColorGreen,
                            ),
                            onPressed: _mostraSenha,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: HexColor("91C7A6")),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      RoundedButton(
                        text: "CONTINUAR",
                        press: () {
                          if (isButtonEnabled(state))
                            _loginBloc.add(LoginWithCredentialsPressed(
                                cpf: cpfController.text,
                                senha: senhaController.text));
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.8,
                        child: OutlineButton(
                          borderSide: BorderSide(color: kPrimaryColorGreen),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return Cadastro(
                                userRepository: widget.userRepository,
                              );
                            }));
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
              ),
            ),
          );
        },
      ),
    );
  }
}
