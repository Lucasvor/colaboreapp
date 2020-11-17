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
                'Histórico de Eventos',
                textAlign: TextAlign.center,
                minFontSize: 25,
                maxFontSize: 30,
                style: TextStyle(
                    color: kPrimaryColorGreen,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'avenir_next_regular.otf'),
              ),
            ),
            SvgPicture.asset(
              "assets/images/Reading list-rafiki.svg",
              height: 200,
              width: 200,
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
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
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
                                child: Text(
                                  '${widget.eventos[index].mensagem} da ong: ${widget.eventos[index].ong}',
                                  textAlign: TextAlign.center,
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
