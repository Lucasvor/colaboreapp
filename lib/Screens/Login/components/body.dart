import 'package:colaboreapp/components/input_field.dart';
import 'package:colaboreapp/components/password_field.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Positioned(
            top: size.height * 0.05,
            child: SvgPicture.asset(
              "assets/images/Planet.svg",
              width: size.width * 0.5,
              color: kBackgroundColor,
            ),
          ),
          InputField(
            hintText: "CPF",
            onChanged: (value) {},
          ),
          PasswordField(
            onChanged: (value) {},
          ),
          Text(
            "Esqueci minha senha",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: HexColor("91C7A6")),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          RoundedButton(
            text: "CONTINUAR",
            press: () {},
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: OutlineButton(
              borderSide: BorderSide(color: kPrimaryColorGreen),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "CADASTRA-SE",
                style: TextStyle(color: HexColor("91C7A6")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
