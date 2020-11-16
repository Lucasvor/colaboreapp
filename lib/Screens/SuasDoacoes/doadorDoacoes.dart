import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/transacao.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class DoadorDoacoes extends StatelessWidget {
  final List<Transacao> transacoes;

  const DoadorDoacoes({Key key, this.transacoes}) : super(key: key);

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
                'Histórico de Doações',
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
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: transacoes.length,
                itemBuilder: (context, index) {
                  return transacoes.length == 0
                      ? Container(
                          width: double.infinity,
                          height: size.height,
                          child: Center(
                            child: Text('Você não fez nenhuma transação!!'),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ListTile(
                            title: AutoSizeText.rich(
                              TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Você doou para a ONG: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${transacoes[index].nomeOng}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            subtitle: AutoSizeText.rich(
                              TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '\nVocê realizou a doação no valor de ',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'R\$ ${transacoes[index].valor}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\nno dia ${transacoes[index].dataHora.day}/${transacoes[index].dataHora.month}/${transacoes[index].dataHora.year}',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                            ),
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
