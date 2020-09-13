import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/main.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class CadastroForm extends StatefulWidget {
  final UserRepository userRepository;

  const CadastroForm({Key key, this.userRepository}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<CadastroForm> {
  final TextEditingController nomeFantasiaController = TextEditingController();
  final TextEditingController cnpjController =
      new MaskedTextController(mask: '000.000.000-00');
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
      _cadastroBloc.add(CadastroCpfChanged(nomeFantasiaController.text));
    });
    cnpjController.addListener(() {
      _cadastroBloc.add(CadastroSenhaChanged(cnpjController.text));
    });
    telController.addListener(() {
      _cadastroBloc.add(CadastroConfirmaSenhaChanged(telController.text));
    });
    dataRegistroController.addListener(() {
      _cadastroBloc
          .add(CadastroConfirmaSenhaChanged(dataRegistroController.text));
    });
    categoriaController.addListener(() {
      _cadastroBloc.add(CadastroConfirmaSenhaChanged(categoriaController.text));
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
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Informações sobre a ONG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: 'Avenir')),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: nomeFantasiaController,
                      validator: null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: kPrimaryColorGreen),
                        labelText: "Nome Fantasia",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: kPrimaryColorGreen,
                          ),
                          onPressed: () {
                            nomeFantasiaController.text = '';
                          },
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      autovalidate: true,
                    ),
                    TextFormField(
                      controller: cnpjController,
                      validator: (_) {
                        return !state.isCpfValid ? 'CNPJ inválido' : null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: kPrimaryColorGreen),
                        labelText: "CNPJ",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: kPrimaryColorGreen,
                          ),
                          onPressed: () {
                            cnpjController.text = '';
                          },
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autovalidate: true,
                    ),
                    TextFormField(
                      controller: telController,
                      validator: (_) {
                        return !state.isCpfValid ? 'Telefone Inválido' : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Telefone",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: kPrimaryColorGreen,
                          ),
                          onPressed: () {
                            telController.text = '';
                          },
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autovalidate: true,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    RoundedButton(
                      text: "Cadastrar",
                      press: () {
                        if (isButtonEnabled(state)) {
                          _cadastroBloc.add(CadastroSubmitted(
                              nomeFantasiaOng: nomeFantasiaController.text,
                              cnpjOng: cnpjController.text,
                              telOng: telController.text,
                              dataRegistroOng: dataRegistroController.text,
                              categoriaOng: categoriaController.text));
                        }
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
