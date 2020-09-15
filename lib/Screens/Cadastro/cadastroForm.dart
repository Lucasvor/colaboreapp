import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/main.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';
import 'cadastro.dart';
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

  CadastroBloc _cadastroBloc;

  void _mostraSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }

  @override
  void initState() {
    super.initState();
    _cadastroBloc = BlocProvider.of<CadastroBloc>(context);
    cpfController.addListener(() {
      _cadastroBloc.add(CadastroCpfChanged(cpfController.text));
    });
  }

  @override
  void dispose() {
    cpfController.dispose();
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
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ]),
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
                        return !state.isCpfValid ? 'Telefone Inválido' : null;
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
                      controller: birthController,
                      validator: (_) {
                        return !state.isCpfValid ? 'Data inválida' : null;
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
                      controller: emailController,
                      validator: (_) {
                        return !state.isCpfValid ? 'E-mail inválido' : null;
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
                                    cpfController.text = '';
                                  },
                                )
                              : null),
                      keyboardType: TextInputType.number,
                      autovalidate: true,
                    ),
                    SizedBox(
                      height: size.height * 0.20,
                    ),
                    RoundedButton(
                      text: "Continuar",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return CadastroFormSenha();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
