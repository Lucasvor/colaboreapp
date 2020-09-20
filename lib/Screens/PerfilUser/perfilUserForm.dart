import 'package:colaboreapp/Screens/EscolheFace/Face.dart';
import 'package:colaboreapp/Screens/ValorDoacao/valorDoacao.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
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
              child: Hero(
                tag: widget.face,
                child: SvgPicture.asset(
                  'assets/images/' + '${widget.face}' + '.svg',
                  height: size.height * 0.20,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              '${widget.usuario.displayName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: size.width * 0.8,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    borderSide: BorderSide(color: kPrimaryColorGreen),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return ValorDoacaoForm();
                          },
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Valor da Doação",
                      style: TextStyle(
                        color: HexColor("91C7A6"),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: size.width * 0.8,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    borderSide: BorderSide(color: kPrimaryColorGreen),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Ongs Favoritas",
                      style: TextStyle(
                        color: HexColor("91C7A6"),
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
