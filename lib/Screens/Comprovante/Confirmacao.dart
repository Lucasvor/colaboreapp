import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import 'Pagamento.dart';

class ConfirmacaoForm extends StatefulWidget {
  final Ong ong;
  final HomeBloc homeBloc;
  final String valorDoacao;
  final User usuario;
  final UserRepository userRepository;

  ConfirmacaoForm(
      {Key key,
      this.ong,
      this.homeBloc,
      this.valorDoacao,
      this.usuario,
      this.userRepository})
      : super(key: key);

  @override
  _ConfirmacaoFormState createState() => _ConfirmacaoFormState();
}

class _ConfirmacaoFormState extends State<ConfirmacaoForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 36,
                        color: kPrimaryColorGreen,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                AutoSizeText.rich(
                  TextSpan(
                    text: 'Você está doando\n',
                    children: <TextSpan>[
                      TextSpan(
                        text: '${widget.valorDoacao}\n',
                        style: TextStyle(
                          color: kPrimaryColorGreen,
                        ),
                      ),
                      TextSpan(
                        text: 'Ajudando-a:\n',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  minFontSize: 24,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10000.0),
                      child: CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: widget.ong.imageUrl,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AutoSizeText(
              '${widget.ong.nome}',
              maxFontSize: 34,
              minFontSize: 26,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Avenir',
                color: kPrimaryColorGreen,
              ),
            ),
            SvgPicture.asset(
              "assets/images/Appreciation-rafiki.svg",
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: RoundedButton(
                text: "CONFIRMAR",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PagamentoForm(
                        homeBloc: widget.homeBloc,
                        ong: widget.ong,
                        valorDoacao: widget.valorDoacao,
                        usuario: widget.usuario,
                        userRepository: widget.userRepository,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
