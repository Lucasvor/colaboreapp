import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/Eventos/criaevento.dart';
import 'package:colaboreapp/Screens/SuasDoacoes/doadorDoacoes.dart';
import 'package:colaboreapp/bloc/HomeOng/homeong_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/Home/home_bloc.dart';
import '../../constants.dart';
import '../../main.dart';

class HomeOngForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;

  const HomeOngForm({Key key, this.userRepository, this.usuario})
      : super(key: key);

  @override
  _HomeOngFormState createState() => _HomeOngFormState();
}

class _HomeOngFormState extends State<HomeOngForm> {
  FirestoreOngs firestoreOngs;
  Ong ong;

  @override
  void initState() {
    firestoreOngs = new FirestoreOngs();
    getOng();
    // TODO: implement initState
    super.initState();
  }

  void getOng() async {
    ong = await firestoreOngs
        .getOng(widget.usuario.email.replaceAll('@colaboreapp.com', ""));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocListener<HomeongBloc, HomeongState>(
      listener: (context, state) {
        if (state.isLoadHome) {}
      },
      child: BlocBuilder<HomeongBloc, HomeongState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: '${widget.usuario.displayName}\n',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: <TextSpan>[
                        // TextSpan(
                        //   text: '  ' + nameShort,
                        //   //'${widget.usuario.displayName}',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 35),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 0.2,
                              margin: EdgeInsets.all(20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FlatButton(
                                  onPressed: () {},
                                  color: kPrimaryColorGreen,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/images/schedule.svg",
                                        height: size.height * 0.1,
                                      ),
                                      Text(
                                        'Imagem da ong',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: size.height * 0.3,
                            margin: EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CriaEventoForm(
                                        usuario: widget.usuario,
                                        contextA: context,
                                        ong: ong,
                                      ),
                                    ),
                                  );
                                },
                                color: kPrimaryColorGreen,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/images/schedule.svg",
                                      height: size.height * 0.1,
                                    ),
                                    Text(
                                      'Criar Evento',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * 0.3,
                            margin: EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FlatButton(
                                onPressed: () async {
                                  var trans = await firestoreOngs
                                      .getTransacaoOng(ong.cnpj);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DoadorDoacoes(
                                        transacoes: trans,
                                        isOng: true,
                                      ),
                                    ),
                                  );
                                },
                                color: kPrimaryColorGreen,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/images/donation.svg",
                                      height: size.height * 0.1,
                                    ),
                                    Text(
                                      'Doações captadas',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RoundedButton(
                        color: Colors.red,
                        text: 'Sair',
                        textColor: Colors.white,
                        press: () async {
                          try {
                            await widget.userRepository.singOut();
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthSplash(),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircleAvatar(String url, String nome) {
    return Hero(
      tag: nome,
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
