import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/usuario.dart';
import 'package:colaboreapp/Screens/Eventos/evento.dart';
import 'package:colaboreapp/Screens/HomeOng/HomeOngForm.dart';
import 'package:colaboreapp/Screens/ListOngs/OngsView.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOng.dart';
import 'package:colaboreapp/Screens/PerfilUser/perfilUser.dart';
import 'package:colaboreapp/Screens/mapa.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../main.dart';

class HomeForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;

  const HomeForm({Key key, this.userRepository, this.usuario})
      : super(key: key);

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  List<String> listOngs = new List();
  Container containerOngs = Container();
  HomeBloc _homeBloc;
  SvgPicture svgPicture;
  String faceHome;
  String nameUser;
  String nameShort;
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
    faceHome = 'face0';
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    svgPicture =
        svgPicture = SvgPicture.asset('assets/images/face0.svg', height: 25);
    containerOngs.build(context);
    _homeBloc.add(LoadingOngs());
    nameUser = '${widget.usuario.displayName}';
    nameShort =
        nameUser.length > 0 ? nameUser.substring(0, nameUser.indexOf(' ')) : '';
    super.initState();
  }

  _navigateAndDisplaySelection(BuildContext context, HomeState state) async {
    if (state.usuario == null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Perfil não disponível no momento.'),
                Icon(Icons.error),
              ],
            ),
            backgroundColor: HexColor("e63946"),
          ),
        );
    } else {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PerfilUser(
            userRepository: widget.userRepository,
            usuario: widget.usuario,
            face: state.usuario.face,
          ),
        ),
      );
      _homeBloc.add(LoadingOngs());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.isLoadingOngs) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Carregando ongs...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: HexColor("91C7A6"),
              ),
            );
          svgPicture = SvgPicture.asset(
            'assets/images/face0.svg',
            height: size.height * 0.06,
          );

          ///Carregando ONggs
          containerOngs = Container(
            height: size.height * 0.4,
            width: size.width,
          );
        }
        if (state.isSucess) {
          Scaffold.of(context)..removeCurrentSnackBar();
          faceHome = state.usuario.face;
          svgPicture = SvgPicture.asset(
            'assets/images/' + '${state.usuario.face}' + '.svg',
            height: size.height * 0.06,
          );
          ongs = state.ongs;
          containerOngs = Container(
            height: size.height * 0.4,
            width: size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: state.ongs
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PerfilOng(
                              ong: item,
                              ongNome: item.nome,
                              usuario: widget.usuario,
                              userRepository: widget.userRepository,
                            ),
                          ),
                        );
                      },
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
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: '${item.nome}',
                                child: CachedNetworkImage(
                                  width: size.width,
                                  imageUrl: item.imageUrl,
                                  placeholder: (context, url) =>
                                      new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      new Icon(
                                    Icons.error,
                                    size: 26,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kPrimaryColorGreen,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    item.nome,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
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
                                text: '  ' + nameShort,
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
                            _navigateAndDisplaySelection(context, state);
                            //_homeBloc.add(LoadingOngs());
                          },
                          child: Hero(
                            tag: faceHome,
                            child: svgPicture,
                          ),
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ListOngs(
                                        homeBloc: _homeBloc,
                                        ongs: ongs,
                                        usuario: widget.usuario,
                                        userRepository: widget.userRepository,
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
                                      builder: (_) => Mapa(
                                        ongs: ongs,
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
                                  onPressed: () async {
                                    var firestoreong = FirestoreOngs();
                                    var listEventos =
                                        await firestoreong.getEventos();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EventoForm(
                                          eventos: listEventos,
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
