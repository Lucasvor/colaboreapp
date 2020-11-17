import 'package:auto_size_text/auto_size_text.dart';
import 'package:colaboreapp/Model/evento.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CriaEventoForm extends StatefulWidget {
  final User usuario;

  const CriaEventoForm({Key key, this.usuario}) : super(key: key);

  @override
  _CriaEventoFormState createState() => _CriaEventoFormState();
}

class _CriaEventoFormState extends State<CriaEventoForm> {
  final TextEditingController descricaoController = TextEditingController();

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
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: kPrimaryColorGreen,
                          ),
                        ),
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: AutoSizeText(
                        'Eventos',
                        textAlign: TextAlign.center,
                        minFontSize: 25,
                        maxFontSize: 30,
                        style: TextStyle(
                            color: kPrimaryColorGreen,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir_next_regular.otf'),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: descricaoController,
                  maxLines: null,
                  style: TextStyle(fontSize: 24),
                  decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColorGreen, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      labelText: 'Preencha com a descrição do evento',
                      hintText: 'Descreva o evento para todos saberem.',
                      suffixIcon: descricaoController.text.length > 0
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: kPrimaryColorGreen,
                              ),
                              onPressed: () {
                                descricaoController.text = '';
                              })
                          : null),
                ),
                RoundedButton(
                  text: "Criar Evento",
                  press: () async {
                    var firestoreOng = FirestoreOngs();
                    var ong = await firestoreOng.getOng(widget.usuario.email
                        .replaceAll('@colaboreapp.com', ""));
                    firestoreOng.makeEvento(new Evento(
                        ong: ong.nome,
                        data: new DateTime.now(),
                        mensagem: descricaoController.text));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
