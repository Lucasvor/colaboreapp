import 'package:colaboreapp/bloc/Login/login_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/CustomDialog.dart';
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
  final MaskedTextController documentController =
      new MaskedTextController(mask: '000.000.000-00');

  final TextEditingController senhaController = TextEditingController();

  bool mostraSenha = true;

  bool get isPopulated =>
      documentController.text.isNotEmpty && senhaController.text.isNotEmpty;

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
    documentController.addListener(() {
      _loginBloc.add(LoginDocumentChange(documento: documentController.text));
    });
    senhaController.addListener(() {
      _loginBloc.add(LoginSenhaChange(senha: senhaController.text));
    });

    documentController.beforeChange = (String previous, String next) {
      if (next.length <= 14) {
        if (documentController.mask != '000.000.000-00')
          documentController.updateMask('000.000.000-00');
      } else if (next.length > 14) {
        documentController.updateMask('00.000.000/0000-00');
      }
      print("{$previous e $next}");
      return true;
    };

    // cpfController.beforeChange = (String previous, String next) {
    //   if (previous.length <= 14) {
    //     if (cpfController.mask != '000.000.000-00')
    //       cpfController.updateMask('000.000.000-00');
    //   } else {
    //     cpfController.updateMask('00.000.000/0000-00');
    //   }
    //   print("{$previous e $next}");
    //   return true;
    // };
  }

  @override
  void dispose() {
    documentController.dispose();
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
                duration: Duration(days: 365),
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
        if (state.isSucessDoador) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
        }
        if (state.isSucessOng) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Não implementadoa ainda'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: HexColor("e63946"),
              ),
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
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/earth.svg",
                        width: size.width * 0.5,
                        color: kBackgroundColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          30,
                          45,
                          30,
                          0,
                        ),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: documentController,
                              validator: (_) {
                                if (documentController.text.length == 0) {
                                  return null;
                                } else if (documentController.text.length <=
                                    14) {
                                  return !state.isCpfValid
                                      ? 'CPF inválido'
                                      : null;
                                } else if (documentController.text.length >
                                    14) {
                                  return !state.isCnpjValid
                                      ? 'CNPJ inválido'
                                      : null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "CPF ou CNPJ",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    documentController.text = '';
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autovalidate: true,
                            ),
                            TextFormField(
                              controller: senhaController,
                              validator: (_) {
                                return !state.isSenhaValid
                                    ? 'Senha inválida'
                                    : null;
                              },
                              obscureText: mostraSenha,
                              decoration: InputDecoration(
                                labelText: "Senha",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: _mostraSenha,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              autovalidate: true,
                            ),
                            Text(
                              "Esqueci minha senha",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: HexColor("91C7A6")),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: RoundedButton(
                                text: "ENTRAR",
                                press: () {
                                  if (isButtonEnabled(state))
                                    _loginBloc.add(
                                      LoginWithCredentialsPressed(
                                        documento: documentController.text,
                                        senha: senhaController.text,
                                      ),
                                    );
                                  else {
                                    Scaffold.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Preencha todos os campos!'),
                                              Icon(Icons.error),
                                            ],
                                          ),
                                          backgroundColor: HexColor("e63946"),
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: size.width * 0.8,
                              child: OutlineButton(
                                borderSide:
                                    BorderSide(color: kPrimaryColorGreen),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      userRepository: widget.userRepository,
                                    ),
                                  );
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (_) {
                                  //   return Cadastro(
                                  //     selecionaCadastro: false,
                                  //   );
                                  // }));
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
                      )
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
