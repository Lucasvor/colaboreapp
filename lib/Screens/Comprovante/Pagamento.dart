import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../main.dart';

class PagamentoForm extends StatefulWidget {
  final Ong ong;
  final HomeBloc homeBloc;
  final String valorDoacao;

  const PagamentoForm({Key key, this.ong, this.homeBloc, this.valorDoacao})
      : super(key: key);

  @override
  _PagamentoFormState createState() => _PagamentoFormState();
}

class _PagamentoFormState extends State<PagamentoForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      'Obrigado pela doação ;)',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SvgPicture.asset(
                  "assets/images/Appreciation-bro.svg",
                  height: 300,
                  width: 300,
                ),
              ),
              AutoSizeText(
                'Este é seu codigo: ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              AutoSizeText(
                '1614616161461610616161616 161616161616161 12312312',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
                maxLines: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: RoundedButton(
                  text: "VOLTAR AO INICIO",
                  press: () async {
                    try {
                      var ongRepo = new FirestoreOngs();
                      var res = await ongRepo.addValorDoacao(
                          widget.ong,
                          double.parse(
                              widget.valorDoacao.replaceAll(",", ".")));
                      if (res) {
                        print("Valor doado com sucesso!");
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } else {
                        Scaffold.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      'Houve algum erro na comunicação com firebase.'),
                                  Icon(Icons.error),
                                ],
                              ),
                              backgroundColor: HexColor("91C7A6"),
                            ),
                          );
                        print("Houve algum erro");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
