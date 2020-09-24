import 'package:colaboreapp/repositories/FirestoreUserRepository.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class Face extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;
  final String face;

  const Face({Key key, this.userRepository, this.usuario, this.face})
      : super(key: key);
  @override
  _Face createState() => _Face();
}

class _Face extends State<Face> {
  List<Container> _faces(BuildContext context) => List.generate(
        20,
        (i) => Container(
          child: InkWell(
            onTap: () async {
              var user = FirestoreUserRepository();
              user.SetFace(
                  widget.usuario.email.replaceAll('@colaboreapp.com', ''), i);
              await new Future.delayed(const Duration(seconds: 1));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/images/face${++i}.svg',
              semanticsLabel: i.toString(),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selecione a foto do seu usuário',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 5,
                padding: EdgeInsets.all(20),
                children: _faces(context),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
