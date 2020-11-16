import 'package:auto_size_text/auto_size_text.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/Comprovante/Confirmacao.dart';
import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class ValorDoacaoForm extends StatefulWidget {
  final ValorDoacaoForm valorDoacao;
  final Ong ong;
  final HomeBloc homeBloc;
  final User usuario;
  final UserRepository userRepository;

  const ValorDoacaoForm(
      {Key key,
      this.valorDoacao,
      this.ong,
      this.homeBloc,
      this.usuario,
      this.userRepository})
      : super(key: key);

  @override
  _ValorDoacaoState createState() => _ValorDoacaoState();
}

class _ValorDoacaoState extends State<ValorDoacaoForm> {
  final valorController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');

  bool get isPopulated => valorController.text.isNotEmpty;

  bool isButtonEnabled(CadastroState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void dispose() {
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 36,
                      color: kPrimaryColorGreen,
                      onPressed: () {
                        // widget.homeBloc.add(LoadingOngs());
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText.rich(
                      TextSpan(text: 'Valor da Doação'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'avenir_next_regular.otf',
                      ),
                      minFontSize: 25,
                      maxFontSize: 30,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: valorController,
                        keyboardType: TextInputType.number,
                        // ignore: deprecated_member_use
                        autovalidate: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Avenir',
                        ),
                        decoration: InputDecoration(
                          labelText: "Valor da Doação",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/images/Make_it_rain-rafiki.svg",
                        height: 300,
                        width: 300,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: RoundedButton(
                    text: "Continuar",
                    press: () async {
                      //aqui deve ir a tela de pagamento.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmacaoForm(
                            homeBloc: widget.homeBloc,
                            ong: widget.ong,
                            valorDoacao: valorController.text,
                            usuario: widget.usuario,
                            userRepository: widget.userRepository,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
