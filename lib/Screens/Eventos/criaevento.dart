import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/evento.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/main.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CriaEventoForm extends StatefulWidget {
  final User usuario;
  final BuildContext contextA;
  final Ong ong;

  const CriaEventoForm({Key key, this.usuario, this.contextA, this.ong})
      : super(key: key);

  @override
  _CriaEventoFormState createState() => _CriaEventoFormState();
}

class _CriaEventoFormState extends State<CriaEventoForm> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: widget.key,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    AutoSizeText(
                      'Crie seu Evento!',
                      textAlign: TextAlign.start,
                      minFontSize: 24,
                      maxFontSize: 30,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: TextField(
                    controller: tituloController,
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                    decoration: new InputDecoration(
                        labelText: 'Dê um nome para o evento',
                        hintText: 'Titulo',
                        suffixIcon: tituloController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: kPrimaryColorGreen,
                                ),
                                onPressed: () {
                                  tituloController.text = '';
                                })
                            : null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: TextField(
                    controller: descricaoController,
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                    decoration: new InputDecoration(
                        labelText: 'Descrição do evento',
                        hintText: 'Conte um pouco do evento.',
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
                ),
                RoundedButton(
                  text: "CRIAR EVENTO",
                  press: () async {
                    try {
                      if (descricaoController.text.length > 10 &&
                          tituloController.text.length > 5) {
                        var firestoreOng = FirestoreOngs();
                        firestoreOng.makeEvento(new Evento(
                            ong: widget.ong.nome,
                            data: new DateTime.now(),
                            titulo: tituloController.text,
                            mensagem: descricaoController.text));
                        Navigator.of(context).pop();
                      } else {
                        Flushbar(
                          title: "Erro",
                          message:
                              "A mensagem da descrição precisa ter mais de 10 caracteres para ser válido.",
                          duration: Duration(seconds: 3),
                          backgroundColor: HexColor("e63946"),
                        )..show(context);
                      }
                    } catch (e) {
                      Flushbar(
                        title: "Erro",
                        message: e.toString(),
                        duration: Duration(seconds: 3),
                        backgroundColor: HexColor("e63946"),
                      )..show(context);
                    }
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
