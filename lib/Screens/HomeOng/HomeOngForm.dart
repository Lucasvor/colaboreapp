import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/ListOngs/OngsView.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOng.dart';
import 'package:colaboreapp/Screens/PerfilUser/perfilUser.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/bloc/HomeOng/homeong_bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
  List<String> listOngs = new List();
  Container containerOngs = Container();
  HomeongBloc _homeOngBloc;
  SvgPicture svgPicture;
  List<Ong> ongs;

  @override
  void initState() {
    listOngs.add("AACD");
    listOngs.add("Viva Rio");
    listOngs.add("Transparência Brasil");
    listOngs.add("Fundação Abrinq");
    listOngs.add("IPAM");
    listOngs.add("Saúde Criança");
    listOngs.add("Instituto da Criança");
    listOngs.add("Vetor Brasil");
    listOngs.add("Centro de Inclusão Digital");
    _homeOngBloc = BlocProvider.of<HomeongBloc>(context);
    svgPicture =
        svgPicture = SvgPicture.asset('assets/images/face0.svg', height: 25);
    containerOngs.build(context);
    _homeOngBloc.add(LoadHomeOng());
    super.initState();
  }

  // _navigateAndDisplaySelection(BuildContext context, HomeongState state) async {
  //   if (state.usuario == null) {
  //     Scaffold.of(context)
  //       ..removeCurrentSnackBar()
  //       ..showSnackBar(
  //         SnackBar(
  //           content: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text('Perfil não disponível no momento.'),
  //               Icon(Icons.error),
  //             ],
  //           ),
  //           backgroundColor: HexColor("e63946"),
  //         ),
  //       );
  //   } else {
  //     var result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => PerfilUser(
  //           userRepository: widget.userRepository,
  //           usuario: widget.usuario,
  //           face: state.usuario.face,
  //         ),
  //       ),
  //     );
  //     _homeOngBloc.add(LoadHomeOng());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocListener<HomeongBloc, HomeongState>(
      listener: (context, state) {},
      child: BlocBuilder<HomeongBloc, HomeongState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Olá,\n',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                //text: '  ' + nameShort,
                                //'${widget.usuario.displayName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            //widget.userRepository.singOut();
                            //_navigateAndDisplaySelection(context, state); HABILITAR ESSE
                            //_homeBloc.add(LoadingOngs());
                          },
                          // child: Hero(
                          //   //tag: faceHome,
                          //   child: svgPicture,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  containerOngs, // cards das ongs
                  Container(
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "assets/images/charity.svg",
                                      height: size.height * 0.1,
                                    ),
                                    Text(
                                      'Doações',
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
                            height: size.height * 0.2,
                            margin: EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeOngForm(),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => Mapa(
                                  //       ongs: ongs,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                color: kPrimaryColorGreen,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/images/search.svg",
                                      height: size.height * 0.1,
                                    ),
                                    Text(
                                      'Descubra',
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
                                        'Eventos',
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
