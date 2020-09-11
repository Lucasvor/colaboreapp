import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

class PerfilOngForm extends StatefulWidget {
  final Ong ong;
  final String ongNome;
  PerfilOngForm({Key key, this.ong, this.ongNome}) : super(key: key);

  @override
  _PerfilOngFormState createState() => _PerfilOngFormState();
}

class _PerfilOngFormState extends State<PerfilOngForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
              tag: '${widget.ong.nome}',
              child: CachedNetworkImage(
                height: size.height * 0.3,
                imageUrl: widget.ong.imageUrl,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              height: size.height * 0.3,
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green[200],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.ong.info ?? "",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            RoundedButton(
              color: kPrimaryColorGreen,
              press: () {
                Navigator.of(context).pop();
              },
              text: 'Voltar',
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
