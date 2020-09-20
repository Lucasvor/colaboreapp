import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/main.dart';
import 'package:colaboreapp/repositories/OngRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class CadastroFormOng extends StatefulWidget {
  final OngRepository ongRepository;

  const CadastroFormOng({Key key, this.ongRepository}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<CadastroFormOng> {
  final TextEditingController nomeFantasiaController = TextEditingController();
  final TextEditingController cnpjController =
      new MaskedTextController(mask: '00.000.000/0000-00');
  final TextEditingController telController =
      new MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController dataRegistroController =
      new MaskedTextController(mask: '00/00/0000');
  final TextEditingController categoriaController = TextEditingController();

  //final TextEditingController senhaController = TextEditingController();
  //final TextEditingController confirmaSenhaController = TextEditingController();

  bool mostraSenha = true;

  bool get isPopulated =>
      nomeFantasiaController.text.isNotEmpty &&
      cnpjController.text.isNotEmpty &&
      telController.text.isNotEmpty &&
      dataRegistroController.text.isNotEmpty &&
      categoriaController.text.isNotEmpty;

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
    nomeFantasiaController.addListener(() {
      _cadastroBloc
          .add(CadastroNomeFantasiaChanged(nomeFantasiaController.text));
    });
    cnpjController.addListener(() {
      _cadastroBloc.add(CadastroCnpjChanged(cnpjController.text));
    });
    telController.addListener(() {
      _cadastroBloc.add(CadastroTelChanged(telController.text));
    });
    dataRegistroController.addListener(() {
      _cadastroBloc
          .add(CadastroDataRegistroChanged(dataRegistroController.text));
    });
    categoriaController.addListener(() {
      _cadastroBloc.add(CadastroCategoriaChanged(categoriaController.text));
    });
  }

  @override
  void dispose() {
    nomeFantasiaController.dispose();
    cnpjController.dispose();
    telController.dispose();
    dataRegistroController.dispose();
    categoriaController.dispose();
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
                              text: 'Informações sobre a ONG',
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
                      controller: nomeFantasiaController,
                      validator: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: "Nome Fantasia",
                        suffixIcon: nomeFantasiaController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: kPrimaryColorGreen,
                                ),
                                onPressed: () {
                                  nomeFantasiaController.text = '';
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
                      controller: cnpjController,
                      validator: (_) {
                        return !state.isCpfValid ? 'CNPJ Inválido' : null;
                      },
                      decoration: InputDecoration(
                        labelText: "CNPJ",
                        suffixIcon: cnpjController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: kPrimaryColorGreen,
                                ),
                                onPressed: () {
                                  cnpjController.text = '';
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
                      controller: dataRegistroController,
                      validator: (_) {
                        return !state.isCpfValid ? 'Data inválida' : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Data de Registro",
                        suffixIcon: dataRegistroController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: kPrimaryColorGreen,
                                ),
                                onPressed: () {
                                  dataRegistroController.text = '';
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
                      controller: categoriaController,
                      validator: (_) {
                        return !state.isCpfValid ? 'Categoria Inválida' : null;
                      },
                      decoration: InputDecoration(
                          labelText: "Categoria",
                          suffixIcon: categoriaController.text.length > 0
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kPrimaryColorGreen,
                                  ),
                                  onPressed: () {
                                    categoriaController.text = '';
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
                      press: () {},
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
