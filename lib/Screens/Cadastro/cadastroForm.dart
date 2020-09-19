import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/main.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';
import 'cadastroFormSenha.dart';

class CadastroForm extends StatefulWidget {
  final UserRepository userRepository;

  const CadastroForm(
      {Key key,
      this.userRepository,
      UserRepository ongRepository,
      bool selecionaCadastro})
      : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<CadastroForm> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController =
      new MaskedTextController(mask: '000.000.000-00');
  final TextEditingController telController =
      new MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController birthController =
      new MaskedTextController(mask: '00/00/0000');
  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool mostraSenha = true;

  bool get isPopulated =>
      nomeController.text.isNotEmpty &&
      cpfController.text.isNotEmpty &&
      telController.text.isNotEmpty &&
      birthController.text.isNotEmpty &&
      emailController.text.isNotEmpty;

  bool isButtonEnabled(CadastroState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool get isSenhaPopulated =>
      senhaController.text.isNotEmpty &&
      confirmaSenhaController.text.isNotEmpty;

  bool isSenhaButtonEnabled(CadastroState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool result;

  CadastroBloc _cadastroBloc;

  @override
  void initState() {
    super.initState();
    _cadastroBloc = BlocProvider.of<CadastroBloc>(context);
    cpfController.addListener(
      () {
        _cadastroBloc.add(CadastroCpfChanged(cpfController.text));
      },
    );
    telController.addListener(() {
      _cadastroBloc.add(CadastroTelChanged(telController.text));
    });
    birthController.addListener(() {
      _cadastroBloc.add(CadastroDateChanged(birthController.text));
    });
    emailController.addListener(() {
      _cadastroBloc.add(CadastroEmailChanged(emailController.text));
    });

    senhaController.addListener(() {
      _cadastroBloc.add(CadastroSenhaChanged(senhaController.text));
    });
  }

  _navigateToSenhaDisplay(BuildContext context, CadastroState state) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return CadastroFormSenha(
            userRepository: widget.userRepository,
            email: emailController.text,
            cadastroBloc: _cadastroBloc,
            cpf: cpfController.text,
            date: birthController.text,
            nome: nomeController.text,
            telefone: telController.text,
            state: state,
          );
        },
      ),
    );
  }

  void _mostraSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }

  @override
  void dispose() {
    cpfController.dispose();
    telController.dispose();
    birthController.dispose();
    emailController.dispose();

    //
    senhaController.dispose();
    confirmaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<CadastroBloc, CadastroState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Cadastro Falhou'),
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
                    Text('Cadastrando...'),
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
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<CadastroBloc, CadastroState>(
        builder: (context, state) {
          if (!state.isSenhaPage) {
            return Container(
              width: double.infinity,
              height: size.height,
              child: SingleChildScrollView(
                child: Form(
                    child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Informações Pessoais',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    fontFamily: 'Avenir'),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      TextFormField(
                        controller: nomeController,
                        validator: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          labelText: "Nome",
                          suffixIcon: nomeController.text.length > 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    nomeController.text = '';
                                  },
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.name,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextFormField(
                        controller: cpfController,
                        validator: (_) {
                          return !state.isCpfValid ? 'CPF inválido' : null;
                        },
                        decoration: InputDecoration(
                          labelText: "CPF",
                          suffixIcon: cpfController.text.length > 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    cpfController.text = '';
                                  },
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextFormField(
                        controller: telController,
                        validator: (_) {
                          return !state.isTelValid ? 'Telefone Inválido' : null;
                        },
                        decoration: InputDecoration(
                          labelText: "Telefone",
                          suffixIcon: telController.text.length > 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    telController.text = '';
                                  },
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextFormField(
                        controller: birthController,
                        validator: (_) {
                          return !state.isDataNascimentoValid
                              ? 'Data inválida'
                              : null;
                        },
                        decoration: InputDecoration(
                          labelText: "Data de Nascimento",
                          suffixIcon: birthController.text.length > 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    birthController.text = '';
                                  },
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (_) {
                          return !state.isEmailValid ? 'E-mail inválido' : null;
                        },
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            suffixIcon: emailController.text.length > 0
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: kPrimaryColorGreen,
                                    ),
                                    onPressed: () {
                                      emailController.text = '';
                                    },
                                  )
                                : null),
                        keyboardType: TextInputType.number,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      RoundedButton(
                        text: "Continuar",
                        press: () {
                          state.update(isSenhaValid: true);
                          if (isButtonEnabled(state)) {
                            //_navigateToSenhaDisplay(context, state);
                            BlocProvider.of<CadastroBloc>(context)
                                .add(CadastroPageSenha());
                          } else {
                            Scaffold.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Preencha todos os campos!'),
                                      Icon(Icons.announcement),
                                    ],
                                  ),
                                  backgroundColor: HexColor("e63946"),
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                )),
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              height: size.height,
              child: SingleChildScrollView(
                child: Form(
                    child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    BlocProvider.of<CadastroBloc>(context)
                                        .add(CadastroPageSenha());
                                  },
                                );
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                          ]),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Crie a sua senha para usar no APP',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Avenir'),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: size.height * 0.20,
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
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
                      TextFormField(
                        controller: confirmaSenhaController,
                        validator: (_) {
                          if (confirmaSenhaController.text.length > 0)
                            return senhaController.text !=
                                    confirmaSenhaController.text
                                ? 'Senha digitada não corresponde com a anterior'
                                : null;
                        },
                        obscureText: mostraSenha,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: kPrimaryColorGreen),
                            labelText: "Confirmar Senha",
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20)),
                        keyboardType: TextInputType.text,
                        autovalidate: true,
                      ),
                      SizedBox(
                        height: size.height * 0.20,
                      ),
                      RoundedButton(
                        text: "Finalizar",
                        press: () {
                          if (isSenhaButtonEnabled(state)) {
                            _cadastroBloc.add(
                              CadastroSubmitted(
                                nome: nomeController.text,
                                cpf: cpfController.text,
                                senha: senhaController.text,
                                dataNascimento: birthController.text,
                                email: emailController.text,
                                telefone: telController.text,
                              ),
                            );
                          } else {
                            Scaffold.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Preencha todos os campos!'),
                                      Icon(Icons.build),
                                    ],
                                  ),
                                  backgroundColor: HexColor("91C7A6"),
                                ),
                              );
                          }
                          // if (isButtonEnabled(state)) {
                          //   _cadastroBloc.add(CadastroSubmitted(
                          //       nome: nomeController.text,
                          //       cpf: cpfController.text,
                          //       senha: senhaController.text));
                          // }
                        },
                      ),
                    ],
                  ),
                )),
              ),
            );
          }
        },
      ),
    );
  }
}
