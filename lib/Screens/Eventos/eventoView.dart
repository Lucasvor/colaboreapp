import 'package:auto_size_text/auto_size_text.dart';
import 'package:colaboreapp/Model/evento.dart';
import 'package:colaboreapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class EventoViewForm extends StatefulWidget {
  final Evento eventos;
  final User usuario;

  const EventoViewForm({Key key, this.eventos, this.usuario}) : super(key: key);

  @override
  _EventoViewFormState createState() => _EventoViewFormState();
}

class _EventoViewFormState extends State<EventoViewForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
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
              child: AutoSizeText.rich(
                TextSpan(
                  text: '${widget.eventos.ong}\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Avenir',
                    color: kPrimaryColorGreen, //qualquer
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.eventos.titulo}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ],
                  //
                ),
                textAlign: TextAlign.center,
                minFontSize: 25,
                maxFontSize: 30,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Avenir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
