import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

    _homeBloc = BlocProvider.of<HomeBloc>(context);
    //
    _homeBloc.add(LoadingOngs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

          ///Carregando ONggs
          containerOngs = Container(
            height: size.height * 0.5,
            width: size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: listOngs
                  .map(
                    (item) => Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: size.height * 0.5,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                            ),
                            // child: SvgPicture.asset(
                            //   "assets/images/earth.svg",
                            //   color: kBackgroundColor,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }
        if (state.isSucess) {
          Scaffold.of(context)..removeCurrentSnackBar();

          containerOngs = Container(
            height: size.height * 0.5,
            width: size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: state.ongs
                  .map(
                    (item) => Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: size.height * 0.5,
                      width: size.width,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: item.imageUrl,
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              item.nome,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          // child: SvgPicture.asset(
                          //   "assets/images/earth.svg",
                          //   color: kBackgroundColor,
                          // ),
                        ],
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
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/earth.svg",
                          width: size.width * 0.1,
                          color: kBackgroundColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ${widget.usuario.displayName}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    containerOngs,
                    Container(
                      height: size.height * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 0.2,
                              margin: EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FlatButton(
                                  onPressed: () {},
                                  color: kPrimaryColorGreen,
                                  child: Text(
                                    'Doações',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 0.2,
                              margin: EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FlatButton(
                                  onPressed: () {},
                                  color: kPrimaryColorGreen,
                                  child: Text(
                                    'Descubra',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}