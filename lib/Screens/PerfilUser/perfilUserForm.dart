import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Screens/EscolheFace/Face.dart';
import 'package:colaboreapp/Screens/SuasDoacoes/doadorDoacoes.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';
import '../../main.dart';

class PerfilUserForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;
  final String face;

  const PerfilUserForm({Key key, this.userRepository, this.usuario, this.face})
      : super(key: key);
  @override
  _PerfilUserFormState createState() => _PerfilUserFormState();
}

class _PerfilUserFormState extends State<PerfilUserForm> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      width: double.infinity,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                  color: kPrimaryColorGreen,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Face(
                      userRepository: widget.userRepository,
                      usuario: widget.usuario,
                    ),
                  ),
                );
              },
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Hero(
                    tag: widget.face,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                child: SvgPicture.asset(
                                    'assets/images/' +
                                        '${widget.face}' +
                                        '.svg',
                                    height: size.height * 0.20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: AutoSizeText(
                '${widget.usuario.displayName}',
                maxLines: 2,
                minFontSize: 25,
                maxFontSize: 30,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: OutlineButton(
                          borderSide: BorderSide(color: kPrimaryColorGreen),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () {
                            //var firestoreongs = new FirestoreOngs();
                            //firestoreongs.setImages();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: AutoSizeText(
                            "Ongs Favoritas",
                            minFontSize: 10,
                            style: TextStyle(
                                color: HexColor("91C7A6"),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                width: size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: OutlineButton(
                          borderSide: BorderSide(color: kPrimaryColorGreen),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () async {
                            var firestoreongs = new FirestoreOngs();
                            var result = await firestoreongs
                                .getTransacoesDoador(widget.usuario.email
                                    .replaceAll('@colaboreapp.com', ""));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DoadorDoacoes(
                                  transacoes: result,
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: AutoSizeText(
                            "Suas Doações",
                            minFontSize: 10,
                            style: TextStyle(
                                color: HexColor("91C7A6"),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                      Navigator.of(context).pop();
                    } catch (e) {}
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
