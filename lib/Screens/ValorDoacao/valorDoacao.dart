import 'package:colaboreapp/bloc/Cadastro/cadastro_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class ValorDoacaoForm extends StatefulWidget {
  final ValorDoacaoForm valorDoacao;

  const ValorDoacaoForm({Key key, this.valorDoacao}) : super(key: key);

  @override
  _ValorDoacaoState createState() => _ValorDoacaoState();
}

class _ValorDoacaoState extends State<ValorDoacaoForm> {
  final valorController = new MoneyMaskedTextController();

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
    return Scaffold(
      body: Container(
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
                          setState(() {
                            Navigator.of(context).pop();
                          });
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
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Valor da Doação',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                fontFamily: 'Avenir',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                SizedBox(
                  height: size.height * 0.25,
                ),
                TextFormField(
                  controller: valorController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  autovalidate: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Avenir',
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 30.0),
                      child: Icon(
                        Icons.attach_money,
                        color: kPrimaryColorGreen,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.33,
                ),
                RoundedButton(
                  text: "Continuar",
                  press: () {
                    //aqui deve ir a tela de pagamento.
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}