import 'package:colaboreapp/Screens/HomeOng/HomeOng.dart';
import 'package:colaboreapp/bloc/HomeOng/homeong_bloc.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOngForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;

  const HomeOngForm({Key key, this.userRepository, this.usuario})
      : super(key: key);

  @override
  _HomeOngFormState createState() => _HomeOngFormState();
}

class _HomeOngFormState extends State<HomeOngForm> {
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
<<<<<<< HEAD
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text('Bem vindo Ong: ${widget.usuario.displayName}'),
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
                          //blalala
                          await widget.userRepository.singOut();
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSplash(),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      },
>>>>>>> 16e0a27f1b733a03a27d65110a550c99763f1e22
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
