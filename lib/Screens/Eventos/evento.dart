import 'package:auto_size_text/auto_size_text.dart';
import 'package:colaboreapp/Model/evento.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class EventoForm extends StatefulWidget {
  final List<Evento> eventos;

  const EventoForm({Key key, this.eventos}) : super(key: key);

  @override
  _EventoFormState createState() => _EventoFormState();
}

class _EventoFormState extends State<EventoForm> {
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
              child: AutoSizeText(
                'Eventos',
                textAlign: TextAlign.center,
                minFontSize: 25,
                maxFontSize: 30,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Avenir'),
              ),
            ),
            Expanded(
              child: widget.eventos.length == 0
                  ? Container(
                      width: double.infinity,
                      height: 400,
                      child: Center(
                        child: Text('Não existe nenhum evento no momento.'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.eventos.length,
                      itemBuilder: (context, index) {
                        return widget.eventos.length == 0
                            ? Container(
                                width: double.infinity,
                                height: 400,
                                child: Center(
                                  child: Text(
                                      'Não existe nenhum evento no momento.'),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                        ),
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          "assets/images/confetti.svg",
                                          width: 80,
                                          height: 80,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kPrimaryColorGreen,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                widget.eventos[index].ong ?? "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                widget.eventos[index]
                                                        .mensagem ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // child: Text(
                                  //   '${widget.eventos[index].mensagem} da ong: ${widget.eventos[index].ong}',
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ),
                              );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
