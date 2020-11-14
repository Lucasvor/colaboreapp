import 'dart:ui';

import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/transacao.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DoadorDoacoes extends StatelessWidget {
  final List<Transacao> transacoes;

  const DoadorDoacoes({Key key, this.transacoes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                            title: Text(
                                'Você doou para a ONG: ${transacoes[index].nomeOng}'),
                            subtitle: Text(
                                'Você realizou a doação no valor de ${transacoes[index].valor}, no dia ${transacoes[index].dataHora.toString()}'),
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
