import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Face extends StatelessWidget {
  final UserRepository userRepository;
  final User usuario;

  const Face({Key key, this.userRepository, this.usuario}) : super(key: key);

  List<Container> _faces() => List.generate(
        21,
        (i) => Container(
          child: SvgPicture.asset(
            'assets/images/face$i.svg',
            semanticsLabel: i.toString(),
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
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text(
              'Selecione a foto do seu usuário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.extent(
                maxCrossAxisExtent: 100,
                padding: EdgeInsets.all(5),
                children: _faces(),
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
